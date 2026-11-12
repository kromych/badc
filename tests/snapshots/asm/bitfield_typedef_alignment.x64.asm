
bitfield_typedef_alignment.x64:	file format elf64-x86-64

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
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movb	$0x1, -0x10(%rbp)
               	movb	$0x2, -0x7(%rbp)
               	movl	-0x8(%rbp), %ecx
               	andq	$-0x8, %rcx
               	orq	$0x5, %rcx
               	movl	%ecx, -0x8(%rbp)
               	shlq	$0x3d, %rcx
               	sarq	$0x3d, %rcx
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	movsbq	-0x7(%rbp), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	movb	$0x0, -0x4(%rbp)
               	movb	$0x0, -0x3(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x4, -0x3(%rbp)
               	movl	-0x7(%rbp), %eax
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x38a432eb, %rax       # imm = 0x38A432EB
               	movl	%eax, -0x7(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$0xf8a432eb, %ecx       # imm = 0xF8A432EB
               	jne	<addr>
               	andq	$-0x40000000, %rax      # imm = 0xC0000000
               	orq	$0x1fffffff, %rax       # imm = 0x1FFFFFFF
               	movl	%eax, -0x7(%rbp)
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0x1fffffff, %eax       # imm = 0x1FFFFFFF
               	jne	<addr>
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x4(%rbp)
               	movb	$0x5, -0x8(%rbp)
               	movb	$0x6, -0x2(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movabsq	$-0xffffffffff01, %r11  # imm = 0xFFFF0000000000FF
               	andq	%r11, %rcx
               	movabsq	$0xfedcba987700, %r11   # imm = 0xFEDCBA987700
               	orq	%r11, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movsbq	-0x8(%rbp), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	sarq	$0x8, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movsbq	-0x2(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movb	$0x9, -0x10(%rbp)
               	movb	$0xa, -0x7(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	andq	$-0x10, %rax
               	orq	$0x8, %rax
               	movw	%ax, -0x8(%rbp)
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$-0x8, %eax
               	jne	<addr>
               	movsbq	-0x7(%rbp), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movb	%al, -0x10(%rbp)
               	movb	%al, -0xf(%rbp)
               	movb	%al, -0xe(%rbp)
               	movb	%al, -0xd(%rbp)
               	movb	%al, -0xc(%rbp)
               	movb	%al, -0xb(%rbp)
               	movb	%al, -0xa(%rbp)
               	movb	%al, -0x9(%rbp)
               	movb	%al, -0x8(%rbp)
               	movb	%al, -0x7(%rbp)
               	movb	%al, -0x6(%rbp)
               	movb	%al, -0x5(%rbp)
               	movb	$0xc, -0xb(%rbp)
               	movb	$0xd, -0xa(%rbp)
               	movl	-0xf(%rbp), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	movl	%ecx, -0xf(%rbp)
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leave
               	retq
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0xb, %eax
               	leave
               	retq
