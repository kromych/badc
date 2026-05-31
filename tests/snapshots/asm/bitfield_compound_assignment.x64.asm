
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
               	movq	%r8, %rdi
               	andq	$0x1, %rdi
               	orq	%rdi, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	andq	$-0xf, %r9
               	movq	%r8, %r11
               	andq	$0x7, %r11
               	shlq	$0x1, %r11
               	orq	%r11, %r9
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	andq	$-0xf1, %r9
               	movq	%r8, %rdi
               	andq	$0xf, %rdi
               	shlq	$0x4, %rdi
               	orq	%rdi, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	andq	$-0xff01, %r9           # imm = 0xFFFF00FF
               	andq	$0xff, %r8
               	shlq	$0x8, %r8
               	orq	%r8, %r9
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r9
               	andq	$-0xf, %r9
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r11
               	sarq	$0x1, %r11
               	andq	$0x7, %r11
               	orq	$0x5, %r11
               	andq	$0x7, %r11
               	shlq	$0x1, %r11
               	orq	%r11, %r9
               	movw	%r9w, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	sarq	$0x1, %r9
               	andq	$0x7, %r9
               	cmpq	$0x5, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	andq	$-0xf, %rax
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rdi
               	sarq	$0x1, %rdi
               	andq	$0x7, %rdi
               	orq	$0x2, %rdi
               	andq	$0x7, %rdi
               	shlq	$0x1, %rdi
               	orq	%rdi, %rax
               	movw	%ax, (%r9)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rdi
               	andq	$-0xf, %rdi
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %r8
               	sarq	$0x1, %r8
               	andq	$0x6, %r8
               	shlq	$0x1, %r8
               	orq	%r8, %rdi
               	movw	%di, (%rax)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rdi
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
               	movzwq	(%r8), %r9
               	sarq	$0x1, %r9
               	andq	$0x7, %r9
               	xorq	$0x7, %r9
               	andq	$0x7, %r9
               	shlq	$0x1, %r9
               	orq	%r9, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	andq	$-0x2, %r9
               	movl	$0x1, %edi
               	andq	$0x1, %rdi
               	orq	%rdi, %r9
               	movw	%r9w, (%rax)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	andq	$-0xf1, %r9
               	movl	$0xc, %eax
               	andq	$0xf, %rax
               	shlq	$0x4, %rax
               	orq	%rax, %r9
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	andq	$-0xff01, %r9           # imm = 0xFFFF00FF
               	movl	$0xc8, %edi
               	andq	$0xff, %rdi
               	shlq	$0x8, %rdi
               	orq	%rdi, %r9
               	movw	%r9w, (%rax)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	andq	$-0xf, %r9
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r8
               	sarq	$0x1, %r8
               	andq	$0x7, %r8
               	xorq	$0x7, %r8
               	andq	$0x7, %r8
               	shlq	$0x1, %r8
               	orq	%r8, %r9
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r9
               	andq	$0x1, %r9
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	sarq	$0x1, %rax
               	andq	$0x7, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x10, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	sarq	$0x4, %r9
               	andq	$0xf, %r9
               	cmpq	$0xc, %r9
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x12, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	andq	$-0xf1, %r9
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r8
               	sarq	$0x4, %r8
               	andq	$0xf, %r8
               	addq	$0x1, %r8
               	andq	$0xf, %r8
               	shlq	$0x4, %r8
               	orq	%r8, %r9
               	movw	%r9w, (%rax)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r9
               	sarq	$0x4, %r9
               	andq	$0xf, %r9
               	cmpq	$0xd, %r9
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	andq	$-0xf1, %rax
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rdi
               	sarq	$0x4, %rdi
               	andq	$0xf, %rdi
               	subq	$0x4, %rdi
               	andq	$0xf, %rdi
               	shlq	$0x4, %rdi
               	orq	%rdi, %rax
               	movw	%ax, (%r9)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x14, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rdi
               	andq	$-0xff01, %rdi          # imm = 0xFFFF00FF
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %r8
               	sarq	$0x8, %r8
               	andq	$0xff, %r8
               	shlq	$0x1, %r8
               	andq	$0xff, %r8
               	shlq	$0x8, %r8
               	orq	%r8, %rdi
               	movw	%di, (%rax)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rdi
               	sarq	$0x8, %rdi
               	andq	$0xff, %rdi
               	movl	$0x190, %r8d            # imm = 0x190
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	movl	$0x100, %eax            # imm = 0x100
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	xorq	%r8, %rdi
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
               	movzwq	(%r8), %r9
               	sarq	$0x4, %r9
               	andq	$0xf, %r9
               	sarq	$0x2, %r9
               	andq	$0xf, %r9
               	shlq	$0x4, %r9
               	orq	%r9, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
