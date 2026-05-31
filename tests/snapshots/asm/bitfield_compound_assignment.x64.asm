
bitfield_compound_assignment.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	andq	$-0x2, %r9
               	xorq	%r8, %r8
               	orq	%r8, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	andq	$-0xf, %r9
               	orq	%r8, %r9
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	andq	$-0xf1, %r9
               	orq	%r8, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	andq	$-0xff01, %r9           # imm = 0xFFFF00FF
               	orq	%r8, %r9
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r9
               	andq	$-0xf, %r9
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x1, %rdi
               	andq	$0x7, %rdi
               	orq	$0x5, %rdi
               	andq	$0x7, %rdi
               	shlq	$0x1, %rdi
               	orq	%rdi, %r9
               	movw	%r9w, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x1, %rdi
               	andq	$0x7, %rdi
               	cmpq	$0x5, %rdi
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	andq	$-0xf, %rax
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x1, %r8
               	andq	$0x7, %r8
               	orq	$0x2, %r8
               	andq	$0x7, %r8
               	shlq	$0x1, %r8
               	orq	%r8, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x1, %r8
               	andq	$0x7, %r8
               	cmpq	$0x7, %r8
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rax
               	andq	$-0xf, %rax
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x1, %rdi
               	andq	$0x6, %rdi
               	shlq	$0x1, %rdi
               	orq	%rdi, %rax
               	movw	%ax, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x1, %rdi
               	andq	$0x7, %rdi
               	cmpq	$0x6, %rdi
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	andq	$-0xf, %rax
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x1, %r8
               	andq	$0x7, %r8
               	xorq	$0x7, %r8
               	andq	$0x7, %r8
               	shlq	$0x1, %r8
               	orq	%r8, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x1, %r8
               	andq	$0x7, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rax
               	andq	$-0x2, %rax
               	movl	$0x1, %edi
               	orq	%rdi, %rax
               	movw	%ax, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	andq	$-0xf1, %rax
               	movl	$0xc0, %r8d
               	orq	%r8, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	movl	$0xc800, %edi           # imm = 0xC800
               	orq	%rdi, %rax
               	movw	%ax, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	andq	$-0xf, %rax
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x1, %r8
               	andq	$0x7, %r8
               	xorq	$0x7, %r8
               	andq	$0x7, %r8
               	shlq	$0x1, %r8
               	orq	%r8, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	andq	$0x1, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x1, %r8
               	andq	$0x7, %r8
               	cmpq	$0x6, %r8
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %r8
               	cmpq	$0xc, %r8
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x8, %r8
               	andq	$0xff, %r8
               	cmpq	$0xc8, %r8
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rax
               	andq	$-0xf1, %rax
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rdi
               	addq	$0x1, %rdi
               	andq	$0xf, %rdi
               	shlq	$0x4, %rdi
               	orq	%rdi, %rax
               	movw	%ax, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rdi
               	cmpq	$0xd, %rdi
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	andq	$-0xf1, %rax
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %r8
               	subq	$0x4, %r8
               	andq	$0xf, %r8
               	shlq	$0x4, %r8
               	orq	%r8, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %r8
               	cmpq	$0x9, %r8
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rax
               	andq	$-0xff01, %rax          # imm = 0xFFFF00FF
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x8, %rdi
               	andq	$0xff, %rdi
               	shlq	$0x1, %rdi
               	andq	$0xff, %rdi
               	shlq	$0x8, %rdi
               	orq	%rdi, %rax
               	movw	%ax, (%r8)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rdi
               	sarq	$0x8, %rdi
               	andq	$0xff, %rdi
               	movl	$0x190, %eax            # imm = 0x190
               	movl	$0x100, %r8d            # imm = 0x100
               	movq	%r8, %r11
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %rax
               	popq	%rdx
               	xorq	%rax, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	andq	$-0xf1, %rax
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %r8
               	sarq	$0x2, %r8
               	andq	$0xf, %r8
               	shlq	$0x4, %r8
               	orq	%r8, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %r8
               	cmpq	$0x2, %r8
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
