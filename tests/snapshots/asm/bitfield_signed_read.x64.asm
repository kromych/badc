
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
               	movzwq	-0x8(%rbp), %rax
               	andq	$-0x4, %rax
               	orq	$0x3, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xd, %rax
               	orq	$0x4, %rax
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	$-0xfff1, %rax          # imm = 0xFFFF000F
               	orq	$0x8000, %rax           # imm = 0x8000
               	movw	%ax, -0x8(%rbp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	sarq	$0x4, %rax
               	shlq	$0x34, %rax
               	sarq	$0x34, %rax
               	cmpl	$0xfffff800, %eax       # imm = 0xFFFFF800
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	andq	$-0x8, %rax
               	orq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	andq	$-0x7f9, %rax           # imm = 0xF807
               	orq	$0x400, %rax            # imm = 0x400
               	movl	%eax, -0x8(%rbp)
               	movabsq	$-0xfffff801, %r11      # imm = 0xFFFFFFFF000007FF
               	andq	%r11, %rax
               	movl	$0xfffff800, %r11d      # imm = 0xFFFFF800
               	orq	%r11, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	shlq	$0x3d, %rcx
               	sarq	$0x3d, %rcx
               	cmpl	$-0x4, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	sarq	$0x3, %rcx
               	andq	$0xff, %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x80, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	sarq	$0xb, %rax
               	shlq	$0x2b, %rax
               	sarq	$0x2b, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x1000, %rcx          # imm = 0xF000
               	orq	$0x7, %rcx
               	movl	%ecx, (%rax)
               	movzwq	(%rax), %rcx
               	andq	$-0x3001, %rcx          # imm = 0xCFFF
               	orq	$0x3000, %rcx           # imm = 0x3000
               	movw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xc001, %rcx          # imm = 0xFFFF3FFF
               	orq	$0x4000, %rcx           # imm = 0x4000
               	movw	%cx, (%rax)
               	movl	(%rax), %eax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	$0xc, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	sarq	$0xe, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
