
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
               	movl	%edi, %eax
               	cltd
               	idivl	%esi
               	retq

<rem32>:
               	movl	%edi, %eax
               	cltd
               	idivl	%esi
               	movq	%rdx, %rax
               	retq

<uquot32>:
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	xorl	%edx, %edx
               	divl	%esi
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
               	shlq	%rdi
               	addq	%rdi, %rax
               	leaq	(%rsi,%rsi,2), %rcx
               	addq	%rcx, %rax
               	addq	$0x5, %rax
               	addq	$0xe, %rax
               	addq	$0x21, %rax
               	addq	$0x34, %rax
               	retq

<digits>:
               	movl	$0x1, %esi
               	xorl	%ecx, %ecx
               	movq	%rcx, %r8
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %r9 # imm = 0x6666666666666667
               	mulq	%r9
               	shrq	%rdx
               	imulq	$0xa, %rdx, %rax
               	subq	%rax, %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %r8
               	incq	%rcx
               	incq	%rsi
               	movq	%rdx, %rdi
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
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rcx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	movq	%rdi, %rax
               	imulq	%rsi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	imulq	$0xa, %rax, %rax
               	subq	%rax, %rdi
               	leaq	(%rcx,%rdi), %rax
               	retq

<wide_quot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r8
               	movq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rcx, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	movq	%rax, %r9
               	xorq	$0x3f, %r9
               	shlxq	%rax, %rcx, %rax
               	movq	%r8, %rdx
               	shrq	%rdx
               	shrxq	%r9, %rdx, %rdx
               	orq	%rdx, %rax
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rdi, %rbx
               	shrq	%rbx
               	movq	%rsi, %r12
               	shlq	$0x3f, %r12
               	orq	%r12, %rbx
               	movq	%rax, %r11
               	movq	%rbx, %rax
               	divq	%r11
               	shrxq	%r9, %rax, %r9
               	testq	%r9, %r9
               	setne	%al
               	movzbq	%al, %rax
               	subq	%rax, %r9
               	movq	%r9, %rax
               	mulq	%r8
               	movq	%r9, %rbx
               	imulq	%rcx, %rbx
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	addq	%rbx, %rdx
               	cmpq	%rax, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%rax, %rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	subq	%rbx, %rax
               	cmpq	%rcx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%r8, %rdi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	addq	%r9, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
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
               	movq	%rax, %rcx
               	movq	%rcx, %rax
               	imulq	%r8, %rax
               	subq	%rax, %rsi
               	movq	%rsi, %rdx
               	movq	%rdi, %rax
               	divq	%r8
               	jmp	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x28(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x30(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x20(%rsp)
               	movq	0x28(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	0x28(%rsp), %rdi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %rdi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	0x30(%rsp), %rdi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %rdi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	0x28(%rsp), %rdi
               	movq	0x20(%rsp), %rsi
               	callq	<addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movabsq	$0xccccccccccccccc, %r11 # imm = 0xCCCCCCCCCCCCCCC
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movq	<rip>, %rsi # <addr>
               	callq	<addr>
               	cmpl	$0x55555555, %eax       # imm = 0x55555555
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xa, %esi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	0x28(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0xbd8, %rax            # imm = 0xBD8
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0xbe2, %rax           # imm = 0xF41E
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %rsi # <addr>
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	callq	<addr>
               	cmpq	$0x1eae56, %rax         # imm = 0x1EAE56
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movl	$0xa, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x16e7c, %rax          # imm = 0x16E7C
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x4, %edx
               	movq	0x28(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0xbb8, %rax            # imm = 0xBB8
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x7, %edx
               	movq	0x30(%rsp), %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0xbbe, %rax           # imm = 0xF442
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x22e0c, %rax          # imm = 0x22E0C
               	jne	<addr>
               	movq	0x30(%rsp), %rdi
               	callq	<addr>
               	cmpq	$-0x9, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	orq	%rax, %rdx
               	leaq	-0x50(%rbp), %rdi
               	movq	%rdx, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	xorq	%r11, %rax
               	movabsq	$0x5555555555555555, %rcx # imm = 0x5555555555555555
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movq	%rdi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
