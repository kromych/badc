
divide_operands.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<quot>:
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	retq

<rem>:
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	retq

<uquot>:
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	retq

<urem>:
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rax
               	retq

<quot32>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	retq

<rem32>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	retq

<uquot32>:
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%esi, %ecx
               	xorl	%edx, %edx
               	divq	%rcx
               	retq

<urem32>:
               	movl	$0x5, %eax
               	retq

<reread>:
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	imulq	$0x3e8, %rax, %rcx      # imm = 0x3E8
               	imulq	%rsi, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	imulq	$0xa, %rdx, %rax
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<six>:
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%rsi,%rsi,2), %rcx
               	addq	%rcx, %rax
               	addq	$0x5, %rax
               	addq	$0xe, %rax
               	addq	$0x21, %rax
               	addq	$0x34, %rax
               	retq

<digits>:
               	movl	$0xa, %r9d
               	movl	$0x1, %esi
               	xorl	%ecx, %ecx
               	movq	%rcx, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdx # imm = 0x6666666666666667
               	movq	%rdx, %r10
               	mulq	%r10
               	movq	%rdx, %rax
               	shrq	%rax
               	movq	%rax, %rdx
               	imulq	%r9, %rdx
               	subq	%rdx, %rdi
               	movq	%rdi, %rdx
               	imulq	%rsi, %rdx
               	addq	%rdx, %r8
               	incq	%rcx
               	incq	%rsi
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	imulq	$0x64, %r8, %rax
               	addq	%rcx, %rax
               	retq

<chain>:
               	movq	%rdx, %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	imulq	$0x3e8, %rcx, %rax      # imm = 0x3E8
               	addq	%rdx, %rax
               	retq

<by_const>:
               	movabsq	$0x4924924924924925, %rcx # imm = 0x4924924924924925
               	movq	%rdi, %rax
               	imulq	%rcx
               	movq	%rdx, %rax
               	sarq	%rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rax, %rcx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	movq	%rdi, %rax
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	imulq	$0xa, %rax, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	leaq	(%rcx,%rdx), %rax
               	retq

<wide_quot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	movq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r9, %rcx
               	cmovel	%r11d, %ecx
               	xorl	$0x3f, %ecx
               	movq	%rcx, %rax
               	xorq	$0x3f, %rax
               	movq	%r9, %rdx
               	shlq	%cl, %rdx
               	movq	%r8, %rcx
               	shrq	%rcx
               	movq	%rcx, %r11
               	movq	%rax, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%rdx, %rcx
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rbx
               	shrq	%rbx
               	movq	%rsi, %r12
               	shlq	$0x3f, %r12
               	orq	%r12, %rbx
               	pushq	%rax
               	movq	%rbx, %rax
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rax, %rcx
               	shrq	%cl, %rdx
               	testq	%rdx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	mulq	%r8
               	movq	%rcx, %rbx
               	imulq	%r9, %rbx
               	movq	%rcx, %rax
               	imulq	%r8, %rax
               	addq	%rbx, %rdx
               	cmpq	%rax, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rax, %rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	negq	%rbx
               	addq	%rax, %rbx
               	cmpq	%r9, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r9, %rbx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r8, %rdi
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rdx
               	orq	%rdx, %rax
               	movq	%rax, %rsi
               	xorq	$0x1, %rsi
               	leaq	(%rcx,%rsi), %rax
               	xorl	%edx, %edx
               	movq	%rsi, %rcx
               	negq	%rcx
               	andq	%rcx, %r8
               	andq	%r9, %rcx
               	cmpq	%r8, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdi, %rsi
               	subq	%r8, %rsi
               	movq	%rbx, %rdi
               	subq	%rcx, %rdi
               	movq	%rdi, %rcx
               	subq	%r9, %rcx
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%ecx, %ecx
               	cmpq	%r8, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %rdx
               	movq	%rdx, %rax
               	imulq	%r8, %rax
               	subq	%rax, %rsi
               	pushq	%rdx
               	movq	%rsi, %rdx
               	movq	%rdi, %rax
               	divq	%r8
               	popq	%rdx
               	imulq	%rax, %r8
               	movq	%rdi, %rsi
               	subq	%r8, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %rcx
               	imulq	%r8, %rcx
               	movq	%rdi, %rsi
               	subq	%rcx, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
               	movq	0x8(%rax), %rbx
               	movq	0x10(%rax), %r12
               	movq	0x18(%rax), %r14
               	movq	%r13, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r13, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rdi
               	movq	0x28(%rax), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rdi
               	movq	0x28(%rax), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r13, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	callq	<addr>
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	0x18(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rdi
               	movq	0x18(%rax), %rsi
               	callq	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x55555555, %eax       # imm = 0x55555555
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xa, %esi
               	callq	<addr>
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r13, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0xbd8, %rax            # imm = 0xBD8
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$-0xbe2, %rax           # imm = 0xF41E
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rdi
               	movq	0x38(%rax), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	callq	<addr>
               	cmpq	$0x1eae56, %rax         # imm = 0x1EAE56
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movl	$0xa, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x16e7c, %rax          # imm = 0x16E7C
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x4, %edx
               	movq	%r13, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0xbb8, %rax            # imm = 0xBB8
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$-0xbbe, %rax           # imm = 0xF442
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rdi
               	callq	<addr>
               	cmpq	$0x22e0c, %rax          # imm = 0x22E0C
               	jne	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$-0x9, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	xorl	%ecx, %ecx
               	movq	(%rax), %rdx
               	movq	(%rax), %rsi
               	orq	%rcx, %rsi
               	leaq	-0x20(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movq	0x8(%rax), %rax
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	xorq	%r11, %rax
               	movabsq	$0x5555555555555555, %rcx # imm = 0x5555555555555555
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
