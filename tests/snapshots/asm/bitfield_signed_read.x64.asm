
bitfield_signed_read.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x4, %rcx
               	orq	$0x3, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xd, %rax
               	orq	$0x4, %rax
               	movw	%ax, (%rdx)
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xfff1, %rax          # imm = 0xFFFF000F
               	orq	$0x8000, %rax           # imm = 0x8000
               	movw	%ax, (%rcx)
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x2, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0x4, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	shlq	$0x34, %rcx
               	sarq	$0x34, %rcx
               	cmpq	$-0x800, %rcx           # imm = 0xF800
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x8, %rcx
               	orq	$0x4, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rdx
               	movl	%ecx, %eax
               	andq	$-0x7f9, %rax           # imm = 0xF807
               	orq	$0x400, %rax            # imm = 0x400
               	movl	%eax, (%rdx)
               	leaq	-0x8(%rbp), %rcx
               	movl	%eax, %eax
               	movabsq	$-0xfffff801, %r11      # imm = 0xFFFFFFFF000007FF
               	andq	%r11, %rax
               	movl	$0xfffff800, %r11d      # imm = 0xFFFFF800
               	orq	%r11, %rax
               	movl	%eax, (%rcx)
               	movl	%eax, %ecx
               	andq	$0x7, %rcx
               	shlq	$0x3d, %rcx
               	sarq	$0x3d, %rcx
               	cmpq	$-0x4, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0x3, %rcx
               	andq	$0xff, %rcx
               	movsbq	%cl, %rcx
               	cmpq	$-0x80, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	sarq	$0xb, %rcx
               	andq	$0x1fffff, %rcx         # imm = 0x1FFFFF
               	shlq	$0x2b, %rcx
               	sarq	$0x2b, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x1000, %rcx          # imm = 0xF000
               	orq	$0x7, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x3001, %rcx          # imm = 0xCFFF
               	orq	$0x3000, %rcx           # imm = 0x3000
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rdx
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xc001, %rax          # imm = 0xFFFF3FFF
               	orq	$0x4000, %rax           # imm = 0x4000
               	movw	%ax, (%rdx)
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %ecx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0xc, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	sarq	$0xe, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
