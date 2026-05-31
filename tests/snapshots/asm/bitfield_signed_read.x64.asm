
bitfield_signed_read.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	andq	$-0x4, %r9
               	movabsq	$-0x1, %r8
               	andq	$0x3, %r8
               	orq	%r8, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r9
               	andq	$-0xd, %r9
               	movl	$0x1, %r11d
               	andq	$0x3, %r11
               	shlq	$0x2, %r11
               	orq	%r11, %r9
               	movw	%r9w, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	andq	$-0xfff1, %r9           # imm = 0xFFFF000F
               	movabsq	$-0x800, %r8            # imm = 0xF800
               	andq	$0xfff, %r8             # imm = 0xFFF
               	shlq	$0x4, %r8
               	orq	%r8, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	andq	$0x3, %r8
               	shlq	$0x3e, %r8
               	sarq	$0x3e, %r8
               	cmpq	$-0x1, %r8
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x2, %r8
               	andq	$0x3, %r8
               	shlq	$0x3e, %r8
               	sarq	$0x3e, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	sarq	$0x4, %r8
               	andq	$0xfff, %r8             # imm = 0xFFF
               	shlq	$0x34, %r8
               	sarq	$0x34, %r8
               	cmpq	$-0x800, %r8            # imm = 0xF800
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	andq	$0x3, %r8
               	shlq	$0x3e, %r8
               	sarq	$0x3e, %r8
               	addq	$0x2, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %eax
               	andq	$-0x8, %rax
               	movabsq	$-0x4, %r11
               	andq	$0x7, %r11
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0x7f9, %rax           # imm = 0xF807
               	movabsq	$-0x80, %r8
               	andq	$0xff, %r8
               	shlq	$0x3, %r8
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movl	(%r8), %eax
               	movabsq	$-0xfffff801, %r11      # imm = 0xFFFFFFFF000007FF
               	andq	%r11, %rax
               	movabsq	$-0x1, %r11
               	andq	$0x1fffff, %r11         # imm = 0x1FFFFF
               	shlq	$0xb, %r11
               	orq	%r11, %rax
               	movl	%eax, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	andq	$0x7, %r11
               	shlq	$0x3d, %r11
               	sarq	$0x3d, %r11
               	cmpq	$-0x4, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x3, %r11
               	andq	$0xff, %r11
               	movsbq	%r11b, %r11
               	cmpq	$-0x80, %r11
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0xb, %r11
               	andq	$0x1fffff, %r11         # imm = 0x1FFFFF
               	shlq	$0x2b, %r11
               	sarq	$0x2b, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	andq	$0x7, %r11
               	shlq	$0x3d, %r11
               	sarq	$0x3d, %r11
               	cmpq	$0x0, %r11
               	jle	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0xb, %r11
               	andq	$0x1fffff, %r11         # imm = 0x1FFFFF
               	shlq	$0x2b, %r11
               	sarq	$0x2b, %r11
               	cmpq	$0x0, %r11
               	jl	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$-0x1000, %rax          # imm = 0xF000
               	movl	$0x7, %r8d
               	andq	$0xfff, %r8             # imm = 0xFFF
               	orq	%r8, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x4, %r8
               	movzwq	(%r8), %rax
               	andq	$-0x4, %rax
               	movabsq	$-0x1, %r11
               	andq	$0x3, %r11
               	orq	%r11, %rax
               	movw	%ax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	addq	$0x4, %r11
               	movzwq	(%r11), %rax
               	andq	$-0xd, %rax
               	movl	$0x1, %r8d
               	andq	$0x3, %r8
               	shlq	$0x2, %r8
               	orq	%r8, %rax
               	movw	%ax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r8d
               	andq	$0xfff, %r8             # imm = 0xFFF
               	cmpq	$0x7, %r8
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	addq	$0x4, %r8
               	movzwq	(%r8), %r8
               	andq	$0x3, %r8
               	shlq	$0x3e, %r8
               	sarq	$0x3e, %r8
               	cmpq	$-0x1, %r8
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	addq	$0x4, %r8
               	movzwq	(%r8), %r8
               	sarq	$0x2, %r8
               	andq	$0x3, %r8
               	shlq	$0x3e, %r8
               	sarq	$0x3e, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %r8d
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movzwq	(%rax), %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	movslq	%r8d, %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x22, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
