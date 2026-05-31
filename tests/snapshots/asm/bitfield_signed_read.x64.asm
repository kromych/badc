
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
               	movzwq	(%r8), %r9
               	andq	$0x3, %r9
               	shlq	$0x3e, %r9
               	sarq	$0x3e, %r9
               	cmpq	$-0x1, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	sarq	$0x2, %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	sarq	$0x4, %r9
               	andq	$0xfff, %r9             # imm = 0xFFF
               	shlq	$0x34, %r9
               	sarq	$0x34, %r9
               	cmpq	$-0x800, %r9            # imm = 0xF800
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	andq	$-0x8, %r9
               	movabsq	$-0x4, %r11
               	andq	$0x7, %r11
               	orq	%r11, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$-0x7f9, %r9            # imm = 0xF807
               	movabsq	$-0x80, %rax
               	andq	$0xff, %rax
               	shlq	$0x3, %rax
               	orq	%rax, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	movabsq	$-0xfffff801, %r11      # imm = 0xFFFFFFFF000007FF
               	andq	%r11, %r9
               	movabsq	$-0x1, %r11
               	andq	$0x1fffff, %r11         # imm = 0x1FFFFF
               	shlq	$0xb, %r11
               	orq	%r11, %r9
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$0x7, %r9
               	shlq	$0x3d, %r9
               	sarq	$0x3d, %r9
               	cmpq	$-0x4, %r9
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x3, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	sarq	$0xb, %r9
               	andq	$0x1fffff, %r9          # imm = 0x1FFFFF
               	shlq	$0x2b, %r9
               	sarq	$0x2b, %r9
               	cmpq	$-0x1, %r9
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	andq	$0x7, %rax
               	shlq	$0x3d, %rax
               	sarq	$0x3d, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	movl	$0x18, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	sarq	$0xb, %r9
               	andq	$0x1fffff, %r9          # imm = 0x1FFFFF
               	shlq	$0x2b, %r9
               	sarq	$0x2b, %r9
               	cmpq	$0x0, %r9
               	jl	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %eax
               	andq	$-0x1000, %rax          # imm = 0xF000
               	movl	$0x7, %r11d
               	andq	$0xfff, %r11            # imm = 0xFFF
               	orq	%r11, %rax
               	movl	%eax, (%r9)
               	leaq	-0x18(%rbp), %r11
               	addq	$0x4, %r11
               	movzwq	(%r11), %rax
               	andq	$-0x4, %rax
               	movabsq	$-0x1, %r9
               	andq	$0x3, %r9
               	orq	%r9, %rax
               	movw	%ax, (%r11)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x4, %r9
               	movzwq	(%r9), %rax
               	andq	$-0xd, %rax
               	movl	$0x1, %r11d
               	andq	$0x3, %r11
               	shlq	$0x2, %r11
               	orq	%r11, %rax
               	movw	%ax, (%r9)
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1f, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x4, %rax
               	movzwq	(%rax), %r11
               	andq	$0x3, %r11
               	shlq	$0x3e, %r11
               	sarq	$0x3e, %r11
               	cmpq	$-0x1, %r11
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	addq	$0x4, %r11
               	movzwq	(%r11), %rax
               	sarq	$0x2, %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x21, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	leaq	-0x18(%rbp), %r11
               	addq	$0x4, %r11
               	movzwq	(%r11), %r9
               	andq	$0x3, %r9
               	shlq	$0x3e, %r9
               	sarq	$0x3e, %r9
               	movslq	%eax, %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x5, %r9
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
