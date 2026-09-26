
int128_divide_edges.x64:	file format elf64-x86-64

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

<udiv>:
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

<umod>:
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
               	movq	%rsi, %rax
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

<sdiv>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rcx, %r8
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	movq	%r8, %rcx
               	sarq	$0x3f, %rcx
               	xorq	%rax, %rdi
               	xorq	%rax, %rsi
               	cmpq	%rax, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdi, %r9
               	subq	%rax, %r9
               	subq	%rax, %rsi
               	movq	%rsi, %rdi
               	subq	%rbx, %rdi
               	xorq	%rcx, %rdx
               	xorq	%rcx, %r8
               	cmpq	%rcx, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	movq	%r8, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %r8
               	subq	%rbx, %r8
               	movq	%rdi, %rdx
               	orq	%r8, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r8, %rdx
               	cmovel	%r11d, %edx
               	xorl	$0x3f, %edx
               	movq	%rdx, %rbx
               	xorq	$0x3f, %rbx
               	movq	%rdx, %r10
               	movq	%r8, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	movq	%rsi, %r12
               	shrq	%r12
               	pushq	%rcx
               	movq	%rbx, %rcx
               	shrq	%cl, %r12
               	popq	%rcx
               	orq	%r12, %rdx
               	movq	%rdi, %r12
               	shrq	%r12
               	movq	%r9, %r13
               	shrq	%r13
               	movq	%rdi, %r14
               	shlq	$0x3f, %r14
               	orq	%r14, %r13
               	movq	%rdx, %r11
               	pushq	%rax
               	movq	%r12, %rdx
               	movq	%r13, %rax
               	divq	%r11
               	movq	%rax, %rdx
               	popq	%rax
               	pushq	%rcx
               	movq	%rbx, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	testq	%rdx, %rdx
               	setne	%bl
               	movzbq	%bl, %rbx
               	subq	%rbx, %rdx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rsi
               	movq	%rdx, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%rdx, %r13
               	imulq	%r8, %r13
               	movq	%rdx, %rbx
               	imulq	%rsi, %rbx
               	addq	%r13, %r12
               	cmpq	%rbx, %r9
               	setb	%r13b
               	movzbq	%r13b, %r13
               	subq	%rbx, %r9
               	subq	%r12, %rdi
               	subq	%r13, %rdi
               	cmpq	%r8, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r8, %rdi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rsi, %r9
               	setb	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %rbx
               	movq	%rbx, %r12
               	xorq	$0x1, %r12
               	addq	%r12, %rdx
               	xorl	%ebx, %ebx
               	negq	%r12
               	andq	%r12, %rsi
               	andq	%r12, %r8
               	cmpq	%rsi, %r9
               	setb	%r12b
               	movzbq	%r12b, %r12
               	negq	%rsi
               	addq	%r9, %rsi
               	subq	%r8, %rdi
               	movq	%rdi, %r8
               	subq	%r12, %r8
               	xorq	%rax, %rcx
               	movq	%rdx, %rax
               	xorq	%rcx, %rax
               	movq	%rbx, %rdx
               	xorq	%rcx, %rdx
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%rcx, %rax
               	subq	%rcx, %rdx
               	subq	%rsi, %rdx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%r8d, %r8d
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rbx
               	popq	%rax
               	movq	%rbx, %rdx
               	imulq	%rsi, %rdx
               	subq	%rdx, %rdi
               	pushq	%rax
               	movq	%rdi, %rdx
               	movq	%r9, %rax
               	divq	%rsi
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rdi
               	imulq	%rsi, %rdi
               	movq	%r9, %rsi
               	subq	%rdi, %rsi
               	jmp	<addr>
               	movq	%r8, %rbx
               	jmp	<addr>
               	pushq	%rax
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rdi
               	imulq	%rsi, %rdi
               	movq	%r9, %rsi
               	subq	%rdi, %rsi
               	xorl	%r8d, %r8d
               	movq	%r8, %rbx
               	jmp	<addr>

<smod>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	movq	%rcx, %r9
               	sarq	$0x3f, %r9
               	movq	%rdi, %rax
               	xorq	%r8, %rax
               	xorq	%r8, %rsi
               	cmpq	%r8, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%r8, %rax
               	subq	%r8, %rsi
               	negq	%rdi
               	addq	%rsi, %rdi
               	xorq	%r9, %rdx
               	xorq	%r9, %rcx
               	cmpq	%r9, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %rsi
               	subq	%r9, %rsi
               	subq	%r9, %rcx
               	movq	%rcx, %r9
               	subq	%rbx, %r9
               	movq	%rdi, %rcx
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%r9, %r9
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%r9, %rcx
               	cmovel	%r11d, %ecx
               	xorl	$0x3f, %ecx
               	movq	%rcx, %rdx
               	xorq	$0x3f, %rdx
               	movq	%rcx, %r10
               	movq	%r9, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movq	%rsi, %rbx
               	shrq	%rbx
               	pushq	%rcx
               	movq	%rdx, %rcx
               	shrq	%cl, %rbx
               	popq	%rcx
               	orq	%rbx, %rcx
               	movq	%rdi, %rbx
               	shrq	%rbx
               	movq	%rax, %r12
               	shrq	%r12
               	movq	%rdi, %r13
               	shlq	$0x3f, %r13
               	orq	%r13, %r12
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rdx
               	movq	%r12, %rax
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, %r11
               	movq	%rdx, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rcx
               	pushq	%rax
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rbx
               	popq	%rax
               	movq	%rcx, %r12
               	imulq	%r9, %r12
               	movq	%rcx, %rdx
               	imulq	%rsi, %rdx
               	addq	%r12, %rbx
               	cmpq	%rdx, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%rdx, %rax
               	movq	%rdi, %rdx
               	subq	%rbx, %rdx
               	movq	%rdx, %rdi
               	subq	%r12, %rdi
               	cmpq	%r9, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r9, %rdi
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rsi, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rbx
               	orq	%rbx, %rdx
               	movq	%rdx, %r12
               	xorq	$0x1, %r12
               	leaq	(%rcx,%r12), %rdx
               	xorl	%ebx, %ebx
               	movq	%r12, %rcx
               	negq	%rcx
               	andq	%rcx, %rsi
               	andq	%r9, %rcx
               	cmpq	%rsi, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	negq	%rsi
               	addq	%rax, %rsi
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	subq	%r9, %rcx
               	movq	%rsi, %rax
               	xorq	%r8, %rax
               	xorq	%r8, %rcx
               	cmpq	%r8, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	subq	%r8, %rax
               	subq	%r8, %rcx
               	movq	%rcx, %rdx
               	subq	%rsi, %rdx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ecx, %ecx
               	cmpq	%rsi, %rdi
               	jb	<addr>
               	pushq	%rax
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rbx
               	popq	%rax
               	movq	%rbx, %rdx
               	imulq	%rsi, %rdx
               	subq	%rdx, %rdi
               	pushq	%rax
               	movq	%rdi, %rdx
               	divq	%rsi
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rdi
               	imulq	%rsi, %rdi
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	jmp	<addr>
               	movq	%rcx, %rbx
               	jmp	<addr>
               	pushq	%rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %rcx
               	imulq	%rsi, %rcx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rbx
               	jmp	<addr>

<reference>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%r8, 0x50(%rsp)
               	movq	%rdi, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	%rsi, 0x8(%rax)
               	movq	%rdx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	xorl	%eax, %eax
               	movl	$0x7f, %edi
               	movq	%rax, %rsi
               	movq	%rax, %rdx
               	movq	%rax, %r9
               	movq	%rsi, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rax, %r12
               	shlq	%r12
               	movq	%rsi, %rcx
               	shlq	%rcx
               	shrq	$0x3f, %rax
               	movq	%rcx, %rsi
               	orq	%rax, %rsi
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r13
               	movq	0x8(%rax), %rax
               	movq	%rdi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r8d
               	movq	%r8, %r14
               	subq	%rcx, %r14
               	movq	%rdi, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r15
               	xorq	$-0x1, %r15
               	movq	%rax, %r10
               	shrq	%cl, %r10
               	movq	%r10, 0x58(%rsp)
               	pushq	%rcx
               	movq	%r14, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	shlq	%rax
               	movq	%rcx, %r10
               	movq	%r13, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%rcx, %rax
               	andq	%r15, %rax
               	movq	0x58(%rsp), %rcx
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	andq	$0x1, %rax
               	orq	%r12, %rax
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%rcx, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r8, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rcx
               	orq	%rbx, %rcx
               	xorq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %rcx
               	cmpq	%r8, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%r8, %rax
               	subq	%rcx, %rsi
               	subq	%rbx, %rsi
               	movl	$0x1, %r8d
               	xorl	%r14d, %r14d
               	movq	%rdi, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %ebx
               	movq	%rbx, %r15
               	subq	%rcx, %r15
               	movq	%rdi, %rbx
               	shrq	$0x6, %rbx
               	negq	%rbx
               	movq	%rbx, %r12
               	xorq	$-0x1, %r12
               	movq	%r8, %r13
               	shlq	%cl, %r13
               	pushq	%rcx
               	movq	%r15, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	shrq	%r8
               	movq	%rcx, %r10
               	movq	%r14, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r8, %rcx
               	movq	%r13, %r8
               	andq	%r12, %r8
               	andq	%r12, %rcx
               	andq	%r13, %rbx
               	orq	%rbx, %rcx
               	orq	%r8, %r9
               	orq	%rcx, %rdx
               	decq	%rdi
               	testl	%edi, %edi
               	jge	<addr>
               	movq	0x50(%rsp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<signed_ok>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rdi, -0x90(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	movq	%rsi, 0x8(%rdi)
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rdx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x8(%rdi), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rax
               	negq	%rcx
               	subq	%rsi, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movq	0x8(%rdx), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rcx
               	testq	%rax, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rax
               	negq	%rcx
               	subq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	leaq	-0x70(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x90(%rbp), %rdi
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	xorq	%r11, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %r8
               	leaq	-0x90(%rbp), %rdi
               	movq	0x8(%rdi), %rax
               	testq	%rax, %rax
               	setl	%al
               	movzbq	%al, %rax
               	leaq	-0x80(%rbp), %rcx
               	movq	0x8(%rcx), %rsi
               	testq	%rsi, %rsi
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpl	%esi, %eax
               	je	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	testq	%rsi, %rsi
               	seta	%r9b
               	movzbq	%r9b, %r9
               	negq	%rsi
               	negq	%rax
               	negq	%r9
               	addq	%rax, %r9
               	leaq	-0x20(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%r9, 0x8(%rax)
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%r8, %rsi
               	xorq	%rdx, %rax
               	movq	%rsi, %rdx
               	orq	%rax, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rsi
               	leaq	-0x90(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	leaq	-0x70(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rcx
               	negq	%rax
               	movq	%rax, %r8
               	subq	%rdi, %r8
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rax
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x118, %rsp            # imm = 0x118
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0xa, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	movabsq	$-0x6666666666666667, %r11 # imm = 0x9999999999999999
               	xorq	%r11, %rax
               	movabsq	$0x1999999999999999, %rcx # imm = 0x1999999999999999
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0xa, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x5, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x2, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x2, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x2, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x7, (%rdi)
               	movq	$0x5, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	$0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x5, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x7, (%rdi)
               	movq	$0x5, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	$0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x7, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x2, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x456, (%rdi)          # imm = 0x456
               	movq	$0x123, 0x8(%rdi)       # imm = 0x123
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x456, %rax            # imm = 0x456
               	movq	%rdx, %rcx
               	xorq	$0x123, %rcx            # imm = 0x123
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x456, (%rdi)          # imm = 0x456
               	movq	$0x123, 0x8(%rdi)       # imm = 0x123
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax
               	movq	(%rax,%r12,8), %rbx
               	leaq	-0x1(%rbx), %rax
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x1(%rbx), %rcx
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rax
               	shrq	%rax
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x3039, (%rdi)         # imm = 0x3039
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x1, (%rdi)
               	movq	%rbx, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x3039, (%rdi)         # imm = 0x3039
               	movq	$0x0, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %rbx
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%rbx, 0x8(%rax)
               	movq	(%rax), %r13
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x13, %r12d
               	jl	<addr>
               	xorl	%r12d, %r12d
               	movl	$0x1, %eax
               	xorl	%esi, %esi
               	leaq	0x40(%r12), %rdx
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %edi
               	movq	%rdi, %r13
               	subq	%rcx, %r13
               	movq	%rdx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	movq	%rax, %rbx
               	shlq	%cl, %rbx
               	movq	%r13, %r10
               	movq	%rax, %r13
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %r13
               	popq	%rcx
               	shrq	%r13
               	movq	%rcx, %r10
               	movq	%rsi, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r13, %rcx
               	movq	%rbx, %r13
               	andq	%r9, %r13
               	andq	%r9, %rcx
               	andq	%rbx, %r8
               	movq	%rcx, %r14
               	orq	%r8, %r14
               	movabsq	$-0x6543210fedcba988, %r11 # imm = 0x9ABCDEF012345678
               	orq	%r11, %r13
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movq	%rdi, %rbx
               	subq	%rcx, %rbx
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %r8
               	xorq	$-0x1, %r8
               	movq	%rax, %r9
               	shlq	%cl, %r9
               	movq	%rbx, %r10
               	movq	%rax, %rbx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rbx
               	popq	%rcx
               	shrq	%rbx
               	movq	%rcx, %r10
               	movq	%rsi, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%rbx, %rcx
               	movq	%r9, %rbx
               	andq	%r8, %rbx
               	andq	%r8, %rcx
               	andq	%r9, %rdx
               	movq	%rcx, %r9
               	orq	%rdx, %r9
               	leaq	0x40(%r12), %rdx
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	movq	%rdi, %r15
               	subq	%rcx, %r15
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rax, %r8
               	shlq	%cl, %r8
               	pushq	%rcx
               	movq	%r15, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	shrq	%rax
               	shlq	%cl, %rsi
               	movq	%rsi, %rcx
               	orq	%rax, %rcx
               	movq	%r8, %rax
               	andq	%rdi, %rax
               	andq	%rdi, %rcx
               	andq	%r8, %rdx
               	orq	%rdx, %rcx
               	cmpq	$0x1, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	decq	%rax
               	subq	%rdx, %rcx
               	orq	%rax, %rbx
               	movq	%r9, %r15
               	orq	%rcx, %r15
               	cmpq	$0x1, %r13
               	setb	%al
               	movzbq	%al, %rax
               	leaq	-0x1(%r13), %rcx
               	movq	%r14, %rdx
               	subq	%rax, %rdx
               	leaq	-0xa0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rdx
               	movq	%r13, (%rdx)
               	movq	%r14, 0x8(%rdx)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	0xf8(%rsp), %r11
               	movq	%r11, 0x8(%rax)
               	movq	(%rax), %r10
               	movq	%r10, 0xf0(%rsp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	0xf0(%rsp), %rcx
               	xorq	0xf8(%rsp), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	%r13, (%rdi)
               	movq	%r14, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%r13, (%rdx)
               	movq	%r14, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	0xf8(%rsp), %r11
               	movq	%r11, 0x8(%rax)
               	movq	(%rax), %r10
               	movq	%r10, 0xf0(%rsp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	0xf0(%rsp), %rcx
               	xorq	0xf8(%rsp), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	movq	$-0x1, (%rcx)
               	movq	$-0x1, 0x8(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	movq	%r13, (%rdx)
               	movq	%r14, 0x8(%rdx)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	%r15, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, %rax
               	cmpq	%rbx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	subq	%r15, %rax
               	subq	%rcx, %rax
               	leaq	-0xa0(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	%r15, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r13
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r13, 0x8(%rax)
               	movq	(%rax), %r14
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r14, %rax
               	movq	%rdx, %rcx
               	xorq	%r13, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x1(%rbx), %rax
               	cmpq	%rbx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%r15, %rcx
               	leaq	-0xa0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, (%rdx)
               	movq	%r15, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %rbx
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%rbx, 0x8(%rax)
               	movq	(%rax), %r13
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x40, %r12d
               	jl	<addr>
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %rbx
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%rbx, 0x8(%rax)
               	movq	(%rax), %r12
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r12, %rax
               	movq	%rdx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	$0x1, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %rbx
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%rbx, 0x8(%rax)
               	movq	(%rax), %r12
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r12, %rax
               	movq	%rdx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x2, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	movabsq	$-0x4000000000000000, %rcx # imm = 0xC000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x2, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x1, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x1, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x1, %rax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x7, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x2, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x3, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x7, (%rdi)
               	movq	$-0x1, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x2, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x1, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x7, (%rdi)
               	movq	$0x0, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x2, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$-0x3, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x7, (%rdi)
               	movq	$0x0, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x2, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x3, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x3, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x1, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$-0x1, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	movabsq	$0x1000000000, %rcx     # imm = 0x1000000000
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$-0x2, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rcx
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	shrq	$0x1d, %rdx
               	xorq	%rdx, %rcx
               	movq	(%rax), %rdx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rdx
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rax
               	shrq	$0x1d, %rax
               	movq	%rdx, %rsi
               	xorq	%rax, %rsi
               	leaq	-0x110(%rbp), %r9
               	movq	%rsi, (%r9)
               	movq	%rcx, 0x8(%r9)
               	movl	$0xa, %r8d
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%edi, %edi
               	cmpq	$0xa, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdx # imm = 0x6666666666666667
               	movq	%rdx, %r10
               	mulq	%r10
               	movq	%rdx, %r13
               	shrq	%r13
               	imulq	$0xa, %r13, %rax
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	movq	%rsi, %rax
               	divq	%r8
               	movq	%rax, %rbx
               	movq	%rbx, %rcx
               	imulq	%r8, %rcx
               	movq	%rsi, %rax
               	subq	%rcx, %rax
               	leaq	-0x40(%rbp), %rdx
               	movq	$0xa, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x100(%rbp), %r8
               	movq	%r9, %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xc0(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%rbx, %rax
               	movq	%r13, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rsi
               	movq	(%rsi), %rdi
               	movq	0x8(%rsi), %rcx
               	movl	$0xa, %edx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%r8d, %r8d
               	cmpq	$0xa, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %r9 # imm = 0x6666666666666667
               	pushq	%rdx
               	mulq	%r9
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%rax, %r9
               	shrq	%r9
               	imulq	$0xa, %r9, %rax
               	subq	%rax, %rcx
               	movq	%rdx, %r11
               	pushq	%rdx
               	movq	%rcx, %rdx
               	movq	%rdi, %rax
               	divq	%r11
               	popq	%rdx
               	imulq	%rax, %rdx
               	movq	%rdi, %rcx
               	subq	%rdx, %rcx
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsi), %rdi
               	movq	0x8(%rsi), %rcx
               	movl	$0x3b9aca07, %esi       # imm = 0x3B9ACA07
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%r8d, %r8d
               	cmpq	%rsi, %rcx
               	jb	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %r9 # imm = 0x89705F3112A28FE5
               	movq	%rcx, %rax
               	mulq	%r9
               	movq	%rdx, %r13
               	shrq	$0x1d, %r13
               	imulq	$0x3b9aca07, %r13, %rax # imm = 0x3B9ACA07
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	movq	%rdi, %rax
               	divq	%rsi
               	movq	%rax, %rbx
               	movq	%rbx, %rcx
               	imulq	%rsi, %rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x30(%rbp), %rdx
               	movq	%rsi, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x100(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%rbx, %rax
               	movq	%r13, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rsi
               	movq	(%rsi), %rdi
               	movq	0x8(%rsi), %rcx
               	movl	$0x3b9aca07, %r9d       # imm = 0x3B9ACA07
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%r8d, %r8d
               	cmpq	%r9, %rcx
               	jb	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rax # imm = 0x89705F3112A28FE5
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	mulq	%r10
               	shrq	$0x1d, %rdx
               	imulq	$0x3b9aca07, %rdx, %rax # imm = 0x3B9ACA07
               	subq	%rax, %rcx
               	pushq	%rdx
               	movq	%rcx, %rdx
               	movq	%rdi, %rax
               	divq	%r9
               	popq	%rdx
               	imulq	%rax, %r9
               	movq	%rdi, %rcx
               	subq	%r9, %rcx
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsi), %rcx
               	movq	0x8(%rsi), %rsi
               	movl	$0x3, %r9d
               	movl	$0x5, %edi
               	movq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x3fffffffffffffff, %r8 # imm = 0xC000000000000001
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%rsi, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%r8
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%r8, %rbx
               	imulq	%r9, %rbx
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	addq	%rbx, %rdx
               	cmpq	%rax, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	negq	%rax
               	addq	%rcx, %rax
               	movq	%rsi, %rcx
               	subq	%rdx, %rcx
               	subq	%rbx, %rcx
               	cmpq	$0x3, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rcx
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x5, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rsi
               	orq	%rsi, %rdx
               	xorq	$0x1, %rdx
               	leaq	(%r8,%rdx), %rbx
               	xorl	%r8d, %r8d
               	negq	%rdx
               	movq	%rdi, %rsi
               	andq	%rdx, %rsi
               	movq	%r9, %rdi
               	andq	%rdx, %rdi
               	cmpq	%rsi, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%rax, %rdx
               	subq	%rsi, %rdx
               	movq	%rcx, %rax
               	subq	%rdi, %rax
               	subq	%r9, %rax
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x5, (%rdx)
               	movq	$0x3, 0x8(%rdx)
               	leaq	-0x100(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xf0(%rbp)
               	leaq	-0xf0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%rbx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	movl	$0x3, %r9d
               	movl	$0x5, %edi
               	movq	%rsi, %rax
               	orq	%r9, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x3fffffffffffffff, %r8 # imm = 0xC000000000000001
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%rsi, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%r8
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r8
               	subq	%rdx, %r8
               	movq	%r8, %rax
               	mulq	%rdi
               	movq	%r8, %rbx
               	imulq	%r9, %rbx
               	movq	%r8, %rax
               	imulq	%rdi, %rax
               	addq	%rbx, %rdx
               	cmpq	%rax, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	negq	%rax
               	addq	%rcx, %rax
               	movq	%rsi, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rsi
               	subq	%rbx, %rsi
               	cmpq	$0x3, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x3, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x5, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %rdx
               	orq	%rdx, %rcx
               	xorq	$0x1, %rcx
               	leaq	(%r8,%rcx), %rdx
               	xorl	%r8d, %r8d
               	negq	%rcx
               	andq	%rcx, %rdi
               	andq	%rcx, %r9
               	cmpq	%rdi, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, %rcx
               	subq	%rdi, %rcx
               	movq	%rsi, %rax
               	subq	%r9, %rax
               	subq	%rbx, %rax
               	leaq	-0x100(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	0x8(%rdx), %rdx
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rdi
               	movq	(%rdi), %rcx
               	movq	0x8(%rdi), %rdx
               	movq	$-0x1, %r8
               	testq	%rdx, %rdx
               	je	<addr>
               	xorl	%esi, %esi
               	cmpq	%r8, %rdx
               	jb	<addr>
               	cmpq	$-0x1, %rdx
               	setae	%r13b
               	movzbq	%r13b, %r13
               	imulq	$-0x1, %r13, %rax
               	subq	%rax, %rdx
               	movq	%rcx, %rax
               	divq	%r8
               	movq	%rax, %rbx
               	leaq	(%rcx,%rbx), %rax
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x100(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%rbx, %rax
               	movq	%r13, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	$-0x1, %r8
               	testq	%rdx, %rdx
               	je	<addr>
               	xorl	%esi, %esi
               	cmpq	%r8, %rdx
               	jb	<addr>
               	cmpq	$-0x1, %rdx
               	setae	%dil
               	movzbq	%dil, %rdi
               	imulq	$-0x1, %rdi, %rax
               	subq	%rax, %rdx
               	movq	%rcx, %rax
               	divq	%r8
               	addq	%rax, %rcx
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdi
               	jmp	<addr>
               	cmpq	$-0x1, %rcx
               	setae	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rdx
               	subq	%rdx, %rcx
               	xorl	%esi, %esi
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	%rsi, %r13
               	jmp	<addr>
               	cmpq	$-0x1, %rcx
               	setae	%bl
               	movzbq	%bl, %rbx
               	imulq	$-0x1, %rbx, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	xorl	%esi, %esi
               	movq	%rsi, %r13
               	jmp	<addr>
               	movabsq	$-0x3333333333333333, %rsi # imm = 0xCCCCCCCCCCCCCCCD
               	movq	%rcx, %rax
               	mulq	%rsi
               	shrq	$0x2, %rdx
               	movq	%rdx, %rax
               	imulq	%rdi, %rax
               	subq	%rax, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	jmp	<addr>
               	movabsq	$-0x3333333333333333, %rsi # imm = 0xCCCCCCCCCCCCCCCD
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rbx
               	shrq	$0x2, %rbx
               	movq	%rbx, %rax
               	imulq	%rdi, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	jmp	<addr>
               	movq	%r8, %rdx
               	jmp	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rcx # imm = 0x89705F3112A28FE5
               	movq	%rdi, %rax
               	mulq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x1d, %rax
               	imulq	$0x3b9aca07, %rax, %rdx # imm = 0x3B9ACA07
               	movq	%rdi, %rcx
               	subq	%rdx, %rcx
               	xorl	%r8d, %r8d
               	movq	%r8, %rdx
               	jmp	<addr>
               	movq	%r8, %r13
               	jmp	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rcx # imm = 0x89705F3112A28FE5
               	movq	%rdi, %rax
               	mulq	%rcx
               	movq	%rdx, %rbx
               	shrq	$0x1d, %rbx
               	imulq	$0x3b9aca07, %rbx, %rcx # imm = 0x3B9ACA07
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	xorl	%r8d, %r8d
               	movq	%r8, %r13
               	jmp	<addr>
               	movq	%r8, %r9
               	jmp	<addr>
               	movq	%rdi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rcx # imm = 0x6666666666666667
               	mulq	%rcx
               	movq	%rdx, %rax
               	shrq	%rax
               	imulq	$0xa, %rax, %rdx
               	movq	%rdi, %rcx
               	subq	%rdx, %rcx
               	xorl	%r8d, %r8d
               	movq	%r8, %r9
               	jmp	<addr>
               	movq	%rdi, %r13
               	jmp	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rcx # imm = 0x6666666666666667
               	mulq	%rcx
               	movq	%rdx, %rbx
               	shrq	%rbx
               	imulq	$0xa, %rbx, %rcx
               	movq	%rsi, %rax
               	subq	%rcx, %rax
               	xorl	%edi, %edi
               	movq	%rdi, %r13
               	jmp	<addr>
               	incq	%r12
               	cmpl	$0xc8, %r12d
               	jl	<addr>
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rcx
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	shrq	$0x1d, %rdx
               	xorq	%rcx, %rdx
               	movq	(%rax), %rcx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rcx
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rsi
               	shrq	$0x1d, %rsi
               	xorq	%rcx, %rsi
               	leaq	-0xf0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	movq	(%rax), %rcx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rcx
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	shrq	$0x1d, %rdx
               	xorq	%rcx, %rdx
               	movq	(%rax), %rcx
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rcx
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rsi
               	shrq	$0x1d, %rsi
               	movq	%rcx, %r8
               	xorq	%rsi, %r8
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rcx
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rax
               	shrq	$0x1d, %rax
               	xorq	%rcx, %rax
               	movq	%rax, %rsi
               	andq	$0x7f, %rsi
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %eax
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movq	%rsi, %rax
               	shrq	$0x6, %rax
               	negq	%rax
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdx, %rdi
               	shrq	%cl, %rdi
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	orq	%rdx, %rcx
               	andq	%rsi, %rcx
               	andq	%rdi, %rax
               	orq	%rax, %rcx
               	movq	%rdi, %rdx
               	andq	%rsi, %rdx
               	leaq	-0xe0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	$0x1, (%rax)
               	movq	$0x0, 0x8(%rax)
               	leaq	-0xf0(%rbp), %rcx
               	leaq	-0xa0(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r12
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r12, 0x8(%rax)
               	movq	(%rax), %r13
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, %rcx
               	shrq	$0x1d, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %rsi
               	andq	$0x7f, %rsi
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %eax
               	movq	%rax, %r9
               	subq	%rcx, %r9
               	movq	%rsi, %rax
               	shrq	$0x6, %rax
               	negq	%rax
               	movq	%rax, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rdx, %rdi
               	shrq	%cl, %rdi
               	pushq	%rcx
               	movq	%r9, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	shrq	%cl, %r8
               	movq	%r8, %rcx
               	orq	%rdx, %rcx
               	andq	%rsi, %rcx
               	andq	%rdi, %rax
               	orq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	%rsi, %rcx
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r12
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r12, 0x8(%rax)
               	movq	(%rax), %r13
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rcx
               	movq	(%rcx), %rax
               	leaq	-0x1(%rax), %rsi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, (%rdx)
               	movq	%rax, %rdx
               	shrq	$0x1d, %rdx
               	xorq	%rdx, %rax
               	movq	(%rcx), %rcx
               	orq	$0x1, %rcx
               	leaq	-0xa0(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	$0x0, 0x8(%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rdx, %r12
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	movq	%r12, 0x8(%rax)
               	movq	(%rax), %r13
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rax
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rdx, 0x8(%rax)
               	movq	(%rax), %rcx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xf0(%rbp), %rdi
               	leaq	-0xe0(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	shrq	%rcx
               	shlq	$0x3f, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	negq	%rax
               	negq	%rdx
               	subq	%rcx, %rdx
               	leaq	-0x30(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	leaq	-0xe0(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	shrq	%rcx
               	shlq	$0x3f, %rax
               	orq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	leaq	-0xe0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	shrq	%rcx
               	shlq	$0x3f, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rsi
               	negq	%rsi
               	negq	%rdx
               	subq	%rcx, %rdx
               	cmpq	$0x1, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorq	$-0x1, %rax
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
