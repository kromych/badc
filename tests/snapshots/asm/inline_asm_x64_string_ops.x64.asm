
inline_asm_x64_string_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	movl	$0xa5a5a5a5, %edx       # imm = 0xA5A5A5A5
               	movq	%rax, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%rdi, -0xc0(%rbp)
               	movq	%rax, -0xb8(%rbp)
               	movq	%rcx, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	movq	-0xb8(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0xb0(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0xa8(%rbp), %rax
               	rep		stosl	%eax, %es:(%rdi)
               	movq	-0xb8(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0xb0(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0xd0(%rbp), %rax
               	movq	-0xc8(%rbp), %rcx
               	movq	-0xc0(%rbp), %rdi
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
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x6, %edx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x80(%rbp), %rdx
               	movq	%rcx, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdi, -0xc0(%rbp)
               	movq	%rax, -0xb8(%rbp)
               	movq	%rcx, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	movq	-0xb8(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0xb0(%rbp), %r10
               	movq	(%r10), %rsi
               	movq	-0xa8(%rbp), %r10
               	movq	(%r10), %rcx
               	rep		movsb	(%rsi), %es:(%rdi)
               	movq	-0xb8(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0xb0(%rbp), %r10
               	movq	%rsi, (%r10)
               	movq	-0xa8(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0xd0(%rbp), %rcx
               	movq	-0xc8(%rbp), %rsi
               	movq	-0xc0(%rbp), %rdi
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
               	leaq	-0x20(%rbp), %rax
               	movl	$0x6, %ecx
               	movq	%rax, -0x88(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movl	$0x64, %eax
               	leaq	-0x88(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	movq	%rax, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%rdi, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rax, -0xa8(%rbp)
               	movq	-0xb8(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0xb0(%rbp), %r10
               	movq	(%r10), %rcx
               	movq	-0xa8(%rbp), %rax
               	repne		scasb	%es:(%rdi), %al
               	movq	-0xb8(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0xb0(%rbp), %r10
               	movq	%rcx, (%r10)
               	movq	-0xd0(%rbp), %rax
               	movq	-0xc8(%rbp), %rcx
               	movq	-0xc0(%rbp), %rdi
               	movq	-0x90(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x2(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x98(%rbp)
               	leaq	-0x98(%rbp), %rax
               	movl	$0xbeef, %ecx           # imm = 0xBEEF
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdi, -0xc8(%rbp)
               	movq	%rax, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	-0xc0(%rbp), %r10
               	movq	(%r10), %rdi
               	movq	-0xb8(%rbp), %rax
               	stosw	%ax, %es:(%rdi)
               	movq	-0xc0(%rbp), %r10
               	movq	%rdi, (%r10)
               	movq	-0xd0(%rbp), %rax
               	movq	-0xc8(%rbp), %rdi
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
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	fninit
               	movl	$0x2a, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
