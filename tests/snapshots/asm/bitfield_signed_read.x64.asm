
bitfield_signed_read.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x4, %rcx
               	movl	$0x3, %edx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xd, %rcx
               	movl	$0x4, %edx
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0xfff1, %rcx          # imm = 0xFFFF000F
               	movl	$0x8000, %edx           # imm = 0x8000
               	orq	%rdx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x2, %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	sarq	$0x4, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	shlq	$0x34, %rax
               	sarq	$0x34, %rax
               	cmpq	$-0x800, %rax           # imm = 0xF800
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x8, %rcx
               	movl	$0x4, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x7f9, %rcx           # imm = 0xF807
               	movl	$0x400, %edx            # imm = 0x400
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movabsq	$-0xfffff801, %r13      # imm = 0xFFFFFFFF000007FF
               	andq	%r13, %rcx
               	movl	$0xfffff800, %edx       # imm = 0xFFFFF800
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	shlq	$0x3d, %rax
               	sarq	$0x3d, %rax
               	cmpq	$-0x4, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0x3, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0xb, %rax
               	andq	$0x1fffff, %rax         # imm = 0x1FFFFF
               	shlq	$0x2b, %rax
               	sarq	$0x2b, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	shlq	$0x3d, %rax
               	sarq	$0x3d, %rax
               	cmpq	$0x0, %rax
               	jle	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	sarq	$0xb, %rax
               	andq	$0x1fffff, %rax         # imm = 0x1FFFFF
               	shlq	$0x2b, %rax
               	sarq	$0x2b, %rax
               	cmpq	$0x0, %rax
               	jl	<addr>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x1000, %rcx          # imm = 0xF000
               	movl	$0x7, %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	0x4(%rax), %rcx
               	andq	$-0x4, %rcx
               	movl	$0x3, %edx
               	orq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	0x4(%rax), %rcx
               	andq	$-0xd, %rcx
               	movl	$0x4, %edx
               	orq	%rdx, %rcx
               	movw	%cx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movzwq	0x4(%rax), %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movzwq	0x4(%rax), %rax
               	sarq	$0x2, %rax
               	andq	$0x3, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	leaq	-0x18(%rbp), %rcx
               	movzwq	0x4(%rcx), %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
