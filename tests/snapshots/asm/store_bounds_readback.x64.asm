
store_bounds_readback.x64:	file format elf64-x86-64

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

<touch_int>:
               	xorq	%rax, %rax
               	retq

<touch_box>:
               	xorq	%rax, %rax
               	retq

<write_int>:
               	movl	%esi, (%rdi)
               	xorq	%rax, %rax
               	retq

<volatile_object>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	setge	%cl
               	movzbq	%cl, %rcx
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x1ff, %eax            # imm = 0x1FF
               	setle	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	leaq	-0x28(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	andq	$0x1ff, %rcx            # imm = 0x1FF
               	movb	%cl, (%rax)
               	movsbq	%cl, %rdx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movsbq	%cl, %rcx
               	cmpl	$-0x38, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rdx, %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	andq	$0x1ff, %rcx            # imm = 0x1FF
               	movb	%cl, 0x1(%rax)
               	movzbq	0x1(%rax), %rcx
               	xorq	$0xc8, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	orq	$0x4, %rbx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	andq	$0x1ff, %rcx            # imm = 0x1FF
               	imulq	$0xc8, %rcx, %rcx
               	movw	%cx, 0x2(%rax)
               	movswq	%cx, %rdx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	movswq	%cx, %rcx
               	cmpl	$0xffff9c40, %ecx       # imm = 0xFFFF9C40
               	sete	%cl
               	movzbq	%cl, %rcx
               	shlq	%rcx
               	addq	%rdx, %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	orq	$0x8, %rbx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	andq	$0x1ff, %rcx            # imm = 0x1FF
               	andq	$0x7, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	decq	%rcx
               	movl	%ecx, 0x4(%rax)
               	movl	0x4(%rax), %ecx
               	cmpl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	seta	%cl
               	movzbq	%cl, %rcx
               	movl	0x4(%rax), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x10, %rbx
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movabsq	$-0x7, %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x20, %rbx
               	leaq	<rip>, %r12
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, (%r12)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	%eax, -0x8(%rbp)
               	movq	(%r12), %rdi
               	movabsq	$-0x3, %rsi
               	callq	<addr>
               	movslq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$-0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	orq	$0x40, %rbx
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	orq	$0x80, %rbx
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
