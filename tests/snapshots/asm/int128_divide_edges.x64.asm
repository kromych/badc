
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
               	shrxq	%r9, %rax, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
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

<umod>:
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
               	shrxq	%r9, %rax, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	movq	%r9, %rax
               	mulq	%r8
               	movq	%r9, %rbx
               	imulq	%rcx, %rbx
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	addq	%rbx, %rdx
               	cmpq	%rax, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	%rax, %rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	movq	%rax, %rsi
               	subq	%r9, %rsi
               	cmpq	%rcx, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r8, %rdi
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	negq	%rax
               	movq	%r8, %rdx
               	andq	%rax, %rdx
               	andq	%rax, %rcx
               	cmpq	%rdx, %rdi
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	movq	%rsi, %rdx
               	subq	%rcx, %rdx
               	subq	%r8, %rdx
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	cmpq	%r8, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rsi
               	movq	%rsi, %rdx
               	movq	%rdi, %rax
               	divq	%r8
               	movq	%rax, %r9
               	movq	%r9, %rcx
               	imulq	%r8, %rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rax
               	xorl	%edx, %edx
               	jmp	<addr>

<sdiv>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
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
               	subq	%rdi, %rsi
               	xorq	%r9, %rdx
               	movq	%rcx, %rdi
               	xorq	%r9, %rdi
               	cmpq	%r9, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %rcx
               	subq	%r9, %rcx
               	movq	%rdi, %rdx
               	subq	%r9, %rdx
               	movq	%rdx, %rdi
               	subq	%rbx, %rdi
               	movq	%rsi, %rdx
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rdi, %rdx
               	cmovel	%r11d, %edx
               	xorl	$0x3f, %edx
               	movq	%rdx, %rbx
               	xorq	$0x3f, %rbx
               	shlxq	%rdx, %rdi, %rdx
               	movq	%rcx, %r12
               	shrq	%r12
               	shrxq	%rbx, %r12, %r12
               	orq	%r12, %rdx
               	movq	%rsi, %r12
               	shrq	%r12
               	movq	%rax, %r13
               	shrq	%r13
               	movq	%rsi, %r14
               	shlq	$0x3f, %r14
               	orq	%r14, %r13
               	movq	%rdx, %r11
               	pushq	%rax
               	movq	%r12, %rdx
               	movq	%r13, %rax
               	divq	%r11
               	movq	%rax, %rdx
               	popq	%rax
               	shrxq	%rbx, %rdx, %rdx
               	testq	%rdx, %rdx
               	setne	%bl
               	movzbq	%bl, %rbx
               	subq	%rbx, %rdx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	mulq	%rcx
               	movq	%rdx, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%rdx, %r13
               	imulq	%rdi, %r13
               	movq	%rdx, %rbx
               	imulq	%rcx, %rbx
               	addq	%r13, %r12
               	cmpq	%rbx, %rax
               	setb	%r13b
               	movzbq	%r13b, %r13
               	negq	%rbx
               	addq	%rax, %rbx
               	movq	%rsi, %rax
               	subq	%r12, %rax
               	subq	%r13, %rax
               	cmpq	%rdi, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %rbx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rsi, %rax
               	xorq	$0x1, %rax
               	addq	%rdx, %rax
               	xorl	%edi, %edi
               	movq	%r8, %rcx
               	xorq	%r9, %rcx
               	xorq	%rcx, %rax
               	movq	%rdi, %rdx
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
               	xorl	%edi, %edi
               	cmpq	%rcx, %rsi
               	jb	<addr>
               	pushq	%rax
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rax, %rdi
               	popq	%rax
               	movq	%rdi, %rdx
               	imulq	%rcx, %rdx
               	subq	%rdx, %rsi
               	movq	%rsi, %rdx
               	divq	%rcx
               	jmp	<addr>
               	xorl	%edx, %edx
               	divq	%rcx
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdi
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
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	xorq	%r8, %rdi
               	xorq	%r8, %rsi
               	cmpq	%r8, %rdi
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdi, %r9
               	subq	%r8, %r9
               	subq	%r8, %rsi
               	subq	%rbx, %rsi
               	xorq	%rax, %rdx
               	movq	%rcx, %rdi
               	xorq	%rax, %rdi
               	cmpq	%rax, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %rdi
               	subq	%rbx, %rdi
               	movq	%rsi, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x7f, %r11d
               	bsrq	%rdi, %rax
               	cmovel	%r11d, %eax
               	xorl	$0x3f, %eax
               	movq	%rax, %rdx
               	xorq	$0x3f, %rdx
               	shlxq	%rax, %rdi, %rax
               	movq	%rcx, %rbx
               	shrq	%rbx
               	shrxq	%rdx, %rbx, %rbx
               	orq	%rbx, %rax
               	movq	%rsi, %rbx
               	shrq	%rbx
               	movq	%r9, %r12
               	shrq	%r12
               	movq	%rsi, %r13
               	shlq	$0x3f, %r13
               	orq	%r13, %r12
               	movq	%rax, %r11
               	pushq	%rdx
               	movq	%rbx, %rdx
               	movq	%r12, %rax
               	divq	%r11
               	popq	%rdx
               	shrxq	%rdx, %rax, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	subq	%rdx, %rax
               	pushq	%rax
               	mulq	%rcx
               	popq	%rax
               	movq	%rax, %rbx
               	imulq	%rdi, %rbx
               	imulq	%rcx, %rax
               	addq	%rdx, %rbx
               	cmpq	%rax, %r9
               	setb	%r12b
               	movzbq	%r12b, %r12
               	movq	%r9, %rdx
               	subq	%rax, %rdx
               	movq	%rsi, %rax
               	subq	%rbx, %rax
               	movq	%rax, %rsi
               	subq	%r12, %rsi
               	cmpq	%rdi, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rcx, %rdx
               	setb	%bl
               	movzbq	%bl, %rbx
               	andq	%rbx, %r9
               	orq	%r9, %rax
               	movq	%rax, %r9
               	xorq	$0x1, %r9
               	movq	%r9, %rax
               	negq	%rax
               	andq	%rax, %rcx
               	andq	%rdi, %rax
               	cmpq	%rcx, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rcx, %rdx
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	subq	%rdi, %rcx
               	movq	%rdx, %rax
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
               	cmpq	%rcx, %rsi
               	jb	<addr>
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rsi
               	movq	%rsi, %rdx
               	movq	%r9, %rax
               	divq	%rcx
               	imulq	%rcx, %rax
               	movq	%r9, %rdx
               	subq	%rax, %rdx
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	xorl	%ecx, %ecx
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
               	movq	%rsi, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	xorl	%eax, %eax
               	movl	$0x7f, %esi
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movq	%rax, %rdi
               	movq	%rcx, %rbx
               	shrq	$0x3f, %rbx
               	movq	%rax, %r12
               	shlq	%r12
               	shlq	%rcx
               	shrq	$0x3f, %rax
               	orq	%rax, %rcx
               	movq	-0x30(%rbp), %r13
               	movq	-0x28(%rbp), %r9
               	movq	%rsi, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %r8d
               	movq	%r8, %r14
               	subq	%rax, %r14
               	movq	%rsi, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r15
               	xorq	$-0x1, %r15
               	shrxq	%rax, %r9, %r10
               	movq	%r10, 0x58(%rsp)
               	shlxq	%r14, %r9, %r9
               	shlq	%r9
               	shrxq	%rax, %r13, %rax
               	orq	%r9, %rax
               	andq	%r15, %rax
               	movq	0x58(%rsp), %r9
               	andq	%r8, %r9
               	orq	%r9, %rax
               	andq	$0x1, %rax
               	orq	%r12, %rax
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	-0x20(%rbp), %r8
               	movq	-0x18(%rbp), %r9
               	cmpq	%r9, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	cmpq	%r9, %rcx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %r9
               	orq	%rbx, %r9
               	xorq	$0x1, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	-0x20(%rbp), %r9
               	movq	-0x18(%rbp), %r8
               	cmpq	%r9, %rax
               	setb	%bl
               	movzbq	%bl, %rbx
               	subq	%r9, %rax
               	subq	%r8, %rcx
               	subq	%rbx, %rcx
               	movl	$0x1, %r8d
               	xorl	%r14d, %r14d
               	movq	%rsi, %r9
               	andq	$0x3f, %r9
               	movl	$0x3f, %ebx
               	movq	%rbx, %r15
               	subq	%r9, %r15
               	movq	%rsi, %rbx
               	shrq	$0x6, %rbx
               	negq	%rbx
               	movq	%rbx, %r12
               	xorq	$-0x1, %r12
               	shlxq	%r9, %r8, %r13
               	shrxq	%r15, %r8, %r8
               	shrq	%r8
               	shlxq	%r9, %r14, %r9
               	orq	%r8, %r9
               	movq	%r13, %r8
               	andq	%r12, %r8
               	andq	%r12, %r9
               	andq	%r13, %rbx
               	orq	%rbx, %r9
               	orq	%r8, %rdi
               	orq	%r9, %rdx
               	decq	%rsi
               	testl	%esi, %esi
               	jge	<addr>
               	movq	0x50(%rsp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	%rdi, %rax
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
               	subq	$0x98, %rsp
               	pushq	%rbx
               	movq	%rdi, -0x90(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	movq	%rsi, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rdx
               	movq	%rcx, -0x78(%rbp)
               	movq	-0x88(%rbp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rax
               	negq	%rcx
               	subq	%rsi, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x78(%rbp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	testq	%rax, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rax
               	negq	%rcx
               	subq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rdx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	leaq	-0x70(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	xorq	%r11, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	movq	-0x88(%rbp), %rcx
               	testq	%rcx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	leaq	-0x80(%rbp), %rsi
               	movq	-0x78(%rbp), %r8
               	testq	%r8, %r8
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpl	%r8d, %ecx
               	je	<addr>
               	movq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %r8
               	testq	%rcx, %rcx
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%rcx, %rbx
               	negq	%rbx
               	movq	%r8, %rcx
               	negq	%rcx
               	movq	%rcx, %r8
               	subq	%r9, %r8
               	leaq	-0x20(%rbp), %rcx
               	movq	%rbx, -0x20(%rbp)
               	movq	%r8, -0x18(%rbp)
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %rcx
               	xorq	%r8, %rax
               	xorq	%rdx, %rcx
               	orq	%rax, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	-0x88(%rbp), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movq	-0x70(%rbp), %rcx
               	movq	-0x68(%rbp), %rsi
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %r8
               	negq	%r8
               	movq	%rsi, %rcx
               	negq	%rcx
               	movq	%rcx, %rsi
               	subq	%rdi, %rsi
               	leaq	-0x10(%rbp), %rcx
               	movq	%r8, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rsi, %rax
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rcx
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rcx
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
               	movq	$-0x1, -0x20(%rbp)
               	movq	$-0x1, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0xa, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	movabsq	$-0x6666666666666667, %r11 # imm = 0x9999999999999999
               	xorq	%r11, %rax
               	movabsq	$0x1999999999999999, %rcx # imm = 0x1999999999999999
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, -0x20(%rbp)
               	movq	$-0x1, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0xa, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
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
               	movq	$-0x1, -0x20(%rbp)
               	movq	$-0x2, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	xorq	$-0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, -0x20(%rbp)
               	movq	$-0x2, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
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
               	movq	$0x7, -0x20(%rbp)
               	movq	$0x5, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	xorq	$0x5, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x7, -0x20(%rbp)
               	movq	$0x5, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
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
               	movq	$-0x1, -0x20(%rbp)
               	movq	$-0x1, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	xorq	$0x1, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, -0x20(%rbp)
               	movq	$-0x1, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x2, -0x20(%rbp)
               	movq	$-0x1, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
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
               	movq	$0x456, -0x20(%rbp)     # imm = 0x456
               	movq	$0x123, -0x18(%rbp)     # imm = 0x123
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	xorq	$0x456, %rax            # imm = 0x456
               	movq	%rdx, %rcx
               	xorq	$0x123, %rcx            # imm = 0x123
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x456, -0x20(%rbp)     # imm = 0x456
               	movq	$0x123, -0x18(%rbp)     # imm = 0x123
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax,%r12,8), %rbx
               	leaq	-0x1(%rbx), %rax
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x1(%rbx), %rcx
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x0, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rbx, %rax
               	shrq	%rax
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x3039, -0xa0(%rbp)    # imm = 0x3039
               	movq	%rax, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x1, -0xa0(%rbp)
               	movq	%rbx, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, -0xa0(%rbp)
               	movq	$-0x1, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$0x3039, -0xa0(%rbp)    # imm = 0x3039
               	movq	$0x0, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r13
               	movq	%rbx, -0x70(%rbp)
               	movq	%r13, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%rbx, %rax
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x13, %r12d
               	jl	<addr>
               	xorl	%r12d, %r12d
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	leaq	0x40(%r12), %rcx
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x3f, %edi
               	movq	%rdi, %r13
               	subq	%rsi, %r13
               	movq	%rcx, %r8
               	shrq	$0x6, %r8
               	negq	%r8
               	movq	%r8, %r9
               	xorq	$-0x1, %r9
               	shlxq	%rsi, %rax, %rbx
               	shrxq	%r13, %rax, %r13
               	shrq	%r13
               	shlxq	%rsi, %rdx, %rsi
               	orq	%r13, %rsi
               	movq	%rbx, %r13
               	andq	%r9, %r13
               	andq	%r9, %rsi
               	andq	%rbx, %r8
               	movq	%rsi, %r14
               	orq	%r8, %r14
               	movabsq	$-0x6543210fedcba988, %r11 # imm = 0x9ABCDEF012345678
               	orq	%r11, %r13
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	movq	%rdi, %rbx
               	subq	%rsi, %rbx
               	shrq	$0x6, %rcx
               	negq	%rcx
               	movq	%rcx, %r8
               	xorq	$-0x1, %r8
               	shlxq	%rsi, %rax, %r9
               	shrxq	%rbx, %rax, %rbx
               	shrq	%rbx
               	shlxq	%rsi, %rdx, %rsi
               	orq	%rbx, %rsi
               	movq	%r9, %rbx
               	andq	%r8, %rbx
               	andq	%r8, %rsi
               	andq	%r9, %rcx
               	movq	%rsi, %r9
               	orq	%rcx, %r9
               	leaq	0x40(%r12), %rsi
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	movq	%rdi, %r15
               	subq	%rcx, %r15
               	shrq	$0x6, %rsi
               	negq	%rsi
               	movq	%rsi, %rdi
               	xorq	$-0x1, %rdi
               	shlxq	%rcx, %rax, %r8
               	shrxq	%r15, %rax, %rax
               	shrq	%rax
               	shlxq	%rcx, %rdx, %rcx
               	orq	%rax, %rcx
               	movq	%r8, %rax
               	andq	%rdi, %rax
               	andq	%rdi, %rcx
               	movq	%r8, %rdx
               	andq	%rsi, %rdx
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
               	movq	%rcx, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%r13, -0x90(%rbp)
               	movq	%r14, -0x88(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf8(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0xf0(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	0xf8(%rsp), %rax
               	movq	%rdx, %rcx
               	xorq	0xf0(%rsp), %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	%r13, -0xa0(%rbp)
               	movq	%r14, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%r13, -0x90(%rbp)
               	movq	%r14, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0xf8(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, 0xf0(%rsp)
               	movq	0xf8(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0xf0(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	0xf8(%rsp), %rax
               	movq	%rdx, %rcx
               	xorq	0xf0(%rsp), %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x1, -0xa0(%rbp)
               	movq	$-0x1, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%r13, -0x90(%rbp)
               	movq	%r14, -0x88(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, -0xa0(%rbp)
               	movq	$-0x1, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	%r15, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
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
               	movq	%rdx, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	%r15, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rdx, %r14
               	movq	%r13, -0x70(%rbp)
               	movq	%r14, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r13, %rax
               	movq	%rdx, %rcx
               	xorq	%r14, %rcx
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x1(%rbx), %rax
               	cmpq	%rbx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%r15, %rcx
               	leaq	-0xa0(%rbp), %rdi
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rbx, -0x90(%rbp)
               	movq	%r15, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r13
               	movq	%rbx, -0x70(%rbp)
               	movq	%r13, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%rbx, %rax
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r12
               	cmpl	$0x40, %r12d
               	jl	<addr>
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, -0xa0(%rbp)
               	movq	$-0x1, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	$0x0, -0x90(%rbp)
               	movq	%rsi, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	%rbx, -0x70(%rbp)
               	movq	%r12, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%rbx, %rax
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0xa0(%rbp), %rdi
               	movq	$-0x1, -0xa0(%rbp)
               	movq	$-0x1, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	$0x1, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	%rbx, -0x70(%rbp)
               	movq	%r12, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%rbx, %rax
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
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
               	movq	$0x0, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
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
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x2, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	movabsq	$-0x4000000000000000, %rcx # imm = 0xC000000000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x2, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
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
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	xorq	$-0x1, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	xorq	$-0x1, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
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
               	movq	$-0x7, -0x20(%rbp)
               	movq	$-0x1, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x2, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	xorq	$-0x3, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x7, -0x20(%rbp)
               	movq	$-0x1, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x2, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	xorq	$-0x1, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x7, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x2, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	xorq	$-0x3, %rax
               	movq	%rdx, %rcx
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x7, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x2, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
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
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x3, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x3, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	-0x20(%rbp), %rdi
               	movq	$-0x1, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x1, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x1, -0x8(%rbp)
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
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movabsq	$0x1000000000, %rcx     # imm = 0x1000000000
               	leaq	-0x10(%rbp), %rdx
               	movq	$0x0, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movq	$-0x1, -0x10(%rbp)
               	movq	$-0x2, -0x8(%rbp)
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
               	leaq	<rip>, %rax      # <addr>
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
               	movq	%rsi, -0x110(%rbp)
               	movq	%rcx, -0x108(%rbp)
               	movl	$0xa, %edi
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%ebx, %ebx
               	cmpq	$0xa, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	mulq	%r8
               	movq	%rdx, %rbx
               	shrq	%rbx
               	imulq	$0xa, %rbx, %rax
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	movq	%rsi, %rax
               	divq	%rdi
               	movq	%rax, %r13
               	leaq	-0x40(%rbp), %rdx
               	movq	%rdi, -0x40(%rbp)
               	movq	$0x0, -0x38(%rbp)
               	leaq	-0x100(%rbp), %r8
               	movq	%r9, %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xc0(%rbp)
               	movq	%rdx, -0xb8(%rbp)
               	xorq	%r13, %rax
               	movq	%rbx, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x110(%rbp), %r9
               	movq	-0x110(%rbp), %rsi
               	movq	-0x108(%rbp), %rcx
               	movl	$0xa, %edi
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0xa, %rcx
               	jb	<addr>
               	movq	%rcx, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %r8 # imm = 0x6666666666666667
               	mulq	%r8
               	shrq	%rdx
               	imulq	$0xa, %rdx, %rax
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	movq	%rsi, %rax
               	divq	%rdi
               	imulq	%rdi, %rax
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x110(%rbp), %rdi
               	movq	-0x108(%rbp), %rcx
               	movl	$0x3b9aca07, %esi       # imm = 0x3B9ACA07
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%ebx, %ebx
               	cmpq	%rsi, %rcx
               	jb	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %r8 # imm = 0x89705F3112A28FE5
               	movq	%rcx, %rax
               	mulq	%r8
               	movq	%rdx, %rbx
               	shrq	$0x1d, %rbx
               	imulq	$0x3b9aca07, %rbx, %rax # imm = 0x3B9ACA07
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	movq	%rdi, %rax
               	divq	%rsi
               	movq	%rax, %r13
               	leaq	-0x30(%rbp), %rdx
               	movq	%rsi, -0x30(%rbp)
               	movq	$0x0, -0x28(%rbp)
               	leaq	-0x100(%rbp), %r8
               	movq	%r9, %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	xorq	%r13, %rax
               	movq	%rbx, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x110(%rbp), %rsi
               	movq	-0x108(%rbp), %rcx
               	movl	$0x3b9aca07, %edi       # imm = 0x3B9ACA07
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	%rdi, %rcx
               	jb	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %r8 # imm = 0x89705F3112A28FE5
               	movq	%rcx, %rax
               	mulq	%r8
               	shrq	$0x1d, %rdx
               	imulq	$0x3b9aca07, %rdx, %rax # imm = 0x3B9ACA07
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	movq	%rsi, %rax
               	divq	%rdi
               	imulq	%rdi, %rax
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x110(%rbp), %rcx
               	movq	-0x108(%rbp), %rsi
               	movl	$0x3, %r8d
               	movl	$0x5, %r9d
               	movq	%rsi, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x3fffffffffffffff, %rdi # imm = 0xC000000000000001
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%rsi, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%rdi
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rdi
               	subq	%rdx, %rdi
               	movq	%rdi, %rax
               	mulq	%r9
               	imulq	%rdi, %r8
               	movq	%rdi, %rax
               	imulq	%r9, %rax
               	addq	%r8, %rdx
               	cmpq	%rax, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	subq	%rax, %rcx
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	subq	%r8, %rax
               	cmpq	$0x3, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x5, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdx, %rax
               	xorq	$0x1, %rax
               	leaq	(%rdi,%rax), %rbx
               	leaq	-0x110(%rbp), %rdi
               	leaq	-0x20(%rbp), %rdx
               	movq	$0x5, -0x20(%rbp)
               	movq	$0x3, -0x18(%rbp)
               	leaq	-0x100(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xf0(%rbp)
               	movq	%rdx, -0xe8(%rbp)
               	xorq	%rbx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x110(%rbp), %rcx
               	movq	-0x108(%rbp), %rsi
               	movl	$0x3, %r8d
               	movl	$0x5, %edi
               	movq	%rsi, %rax
               	orq	%r8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x3fffffffffffffff, %r9 # imm = 0xC000000000000001
               	movq	%rsi, %rdx
               	shrq	%rdx
               	movq	%rcx, %rax
               	shrq	%rax
               	movq	%rsi, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rax
               	divq	%r9
               	shrq	%rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	movq	%r9, %rax
               	mulq	%rdi
               	movq	%r9, %rax
               	imulq	%r8, %rax
               	imulq	%rdi, %r9
               	addq	%rax, %rdx
               	cmpq	%r9, %rcx
               	setb	%bl
               	movzbq	%bl, %rbx
               	movq	%rcx, %rax
               	subq	%r9, %rax
               	movq	%rsi, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	subq	%rbx, %rdx
               	cmpq	$0x3, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x3, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x5, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rsi
               	orq	%rsi, %rcx
               	xorq	$0x1, %rcx
               	negq	%rcx
               	movq	%rdi, %rsi
               	andq	%rcx, %rsi
               	movq	%r8, %rdi
               	andq	%rcx, %rdi
               	cmpq	%rsi, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	movq	%rax, %rcx
               	subq	%rsi, %rcx
               	movq	%rdx, %rax
               	subq	%rdi, %rax
               	subq	%r8, %rax
               	movq	-0x100(%rbp), %rdx
               	movq	-0xf8(%rbp), %rsi
               	xorq	%rdx, %rcx
               	xorq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rsi
               	movq	-0x110(%rbp), %rax
               	movq	-0x108(%rbp), %rdx
               	movq	$-0x1, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorl	%ebx, %ebx
               	cmpq	%rcx, %rdx
               	jb	<addr>
               	cmpq	$-0x1, %rdx
               	setae	%bl
               	movzbq	%bl, %rbx
               	imulq	$-0x1, %rbx, %rdi
               	subq	%rdi, %rdx
               	divq	%rcx
               	movq	%rax, %r13
               	leaq	-0x10(%rbp), %rdx
               	movq	%rcx, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x100(%rbp), %r8
               	movq	%rsi, %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0xe0(%rbp)
               	movq	%rdx, -0xd8(%rbp)
               	xorq	%r13, %rax
               	movq	%rbx, %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x110(%rbp), %rcx
               	movq	-0x108(%rbp), %rdx
               	movq	$-0x1, %rsi
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	cmpq	$-0x1, %rdx
               	setae	%dil
               	movzbq	%dil, %rdi
               	imulq	$-0x1, %rdi, %rax
               	subq	%rax, %rdx
               	movq	%rcx, %rax
               	divq	%rsi
               	addq	%rax, %rcx
               	movq	-0x100(%rbp), %rax
               	movq	-0xf8(%rbp), %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %rcx
               	setae	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rax
               	subq	%rax, %rcx
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	setae	%r13b
               	movzbq	%r13b, %r13
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	jmp	<addr>
               	movabsq	$-0x3333333333333333, %rsi # imm = 0xCCCCCCCCCCCCCCCD
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rsi
               	shrq	$0x2, %rsi
               	movq	%rsi, %rax
               	imulq	%rdi, %rax
               	subq	%rax, %rcx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x3333333333333333, %rsi # imm = 0xCCCCCCCCCCCCCCCD
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rbx
               	shrq	$0x2, %rbx
               	jmp	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rcx # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rdx, %rax
               	shrq	$0x1d, %rax
               	imulq	$0x3b9aca07, %rax, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	jmp	<addr>
               	movabsq	$-0x768fa0ceed5d701b, %rcx # imm = 0x89705F3112A28FE5
               	movq	%rdi, %rax
               	mulq	%rcx
               	movq	%rdx, %r13
               	shrq	$0x1d, %r13
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	jmp	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rcx # imm = 0x6666666666666667
               	mulq	%rcx
               	movq	%rdx, %rax
               	shrq	%rax
               	imulq	$0xa, %rax, %rax
               	movq	%rsi, %rcx
               	subq	%rax, %rcx
               	jmp	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rcx # imm = 0x6666666666666667
               	mulq	%rcx
               	movq	%rdx, %r13
               	shrq	%r13
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	jmp	<addr>
               	incq	%r12
               	cmpl	$0xc8, %r12d
               	jl	<addr>
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax      # <addr>
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
               	xorq	%rsi, %rcx
               	movq	%rcx, -0xf0(%rbp)
               	movq	%rdx, -0xe8(%rbp)
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
               	movq	%rax, %rcx
               	andq	$0x7f, %rcx
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	shrq	$0x6, %rcx
               	negq	%rcx
               	movq	%rcx, %rsi
               	xorq	$-0x1, %rsi
               	shrxq	%rax, %rdx, %rdi
               	shlxq	%r9, %rdx, %rdx
               	shlq	%rdx
               	shrxq	%rax, %r8, %rax
               	orq	%rdx, %rax
               	andq	%rsi, %rax
               	andq	%rdi, %rcx
               	orq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	%rsi, %rcx
               	leaq	-0xe0(%rbp), %rsi
               	movq	%rax, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$0x1, -0xe0(%rbp)
               	movq	$0x0, -0xd8(%rbp)
               	leaq	-0xf0(%rbp), %rax
               	leaq	-0xa0(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x90(%rbp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rdx, %r13
               	movq	%r12, -0x70(%rbp)
               	movq	%r13, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r12, %rax
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0xf0(%rbp), %r8
               	movq	-0xe8(%rbp), %rcx
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rax
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, (%rdx)
               	movq	%rax, %rdx
               	shrq	$0x1d, %rdx
               	xorq	%rdx, %rax
               	movq	%rax, %rdx
               	andq	$0x7f, %rdx
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	movq	%rsi, %r9
               	subq	%rax, %r9
               	shrq	$0x6, %rdx
               	negq	%rdx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	shrxq	%rax, %rcx, %rdi
               	shlxq	%r9, %rcx, %rcx
               	shlq	%rcx
               	shrxq	%rax, %r8, %rax
               	orq	%rcx, %rax
               	andq	%rsi, %rax
               	movq	%rdi, %rcx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rdi, %rcx
               	andq	%rsi, %rcx
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rdi
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rdx, %r13
               	movq	%r12, -0x70(%rbp)
               	movq	%r13, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r12, %rax
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0xe0(%rbp), %rax
               	leaq	-0x1(%rax), %rdx
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rax
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, %rcx
               	shrq	$0x1d, %rcx
               	xorq	%rcx, %rax
               	movq	-0xe0(%rbp), %rsi
               	orq	$0x1, %rsi
               	leaq	-0xa0(%rbp), %rdi
               	movq	%rax, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	leaq	-0x90(%rbp), %rdx
               	movq	%rsi, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	leaq	-0x80(%rbp), %r8
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rdx, %r13
               	movq	%r12, -0x70(%rbp)
               	movq	%r13, -0x68(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	-0x90(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	xorq	%r12, %rax
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
               	movq	%rdx, -0xc8(%rbp)
               	movq	-0x80(%rbp), %rcx
               	movq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rax
               	movq	%rdx, %rcx
               	xorq	%rsi, %rcx
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
               	movq	-0xf0(%rbp), %rcx
               	movq	-0xe8(%rbp), %rax
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
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	leaq	-0xe0(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	-0xf0(%rbp), %rcx
               	movq	-0xe8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	shrq	%rcx
               	shlq	$0x3f, %rax
               	orq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdi
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	-0xe0(%rbp), %rcx
               	movq	-0xd8(%rbp), %rax
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
               	movq	%rax, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
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
