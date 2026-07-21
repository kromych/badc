
inline_asm_x64_string_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fill32>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	movl	%edx, %edx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rax
               	rep		stosl	%eax, %es:(%rdi)
               	movq	-0x18(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<copy8>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdx, 0x20(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	movq	%rdx, 0x30(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	leaq	0x30(%rbp), %rdx
               	movq	%rcx, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0x8(%rbp), %r10
               	movq	(%r10), %rcx
               	rep		movsb	(%rsi), %es:(%rdi)
               	movq	-0x18(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0x8(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rsi
               	movq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<scan8>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movsbq	%dl, %rdx
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	0x10(%rbp), %rax
               	leaq	0x20(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0x8(%rbp), %rax
               	repne		scasb	%es:(%rdi), %al
               	movq	-0x18(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x10(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x20(%rbp), %rdi
               	movq	0x20(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<store16>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x10(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0x8(%rbp), %rax
               	stosw	%ax, %es:(%rdi)
               	movq	-0x10(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rdi
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x4, %esi
               	movl	$0xa5a5a5a5, %edx       # imm = 0xA5A5A5A5
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x61, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x28(%rbp), %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x62, %ecx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, 0x1(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x63, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x64, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x65, %ecx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x66, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x28(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x6, %edx
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rsi
               	leaq	0x61(%rcx), %rdx
               	movslq	%edx, %rdi
               	movsbq	%dil, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x6, %rcx
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x6, %esi
               	movl	$0x64, %edx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x2(%rax)
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xbeef, %esi           # imm = 0xBEEF
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movzwq	(%rax), %rax
               	xorq	$0xbeef, %rax           # imm = 0xBEEF
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movzwq	0x2(%rax), %rax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	fninit
               	movl	$0x2a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
