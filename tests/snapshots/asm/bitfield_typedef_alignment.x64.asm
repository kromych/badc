
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
               	movq	$0x1, -0x10(%rbp)
               	movq	$0x200, -0x8(%rbp)      # imm = 0x200
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
               	movb	$0x0, -0x3(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	movw	$0x400, -0x4(%rbp)      # imm = 0x400
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
               	movabsq	$0x6000000000005, %rax  # imm = 0x6000000000005
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0xffffffffff01, %r11  # imm = 0xFFFF0000000000FF
               	andq	%r11, %rax
               	movabsq	$0xfedcba987700, %r11   # imm = 0xFEDCBA987700
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movsbq	-0x8(%rbp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	sarq	$0x8, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	-0x2(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x9, -0x10(%rbp)
               	movq	$0xa00, -0x8(%rbp)      # imm = 0xA00
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
               	movb	%al, -0xb(%rbp)
               	movb	%al, -0xa(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movabsq	$0xd0c0000000000, %rcx  # imm = 0xD0C0000000000
               	movq	%rcx, -0x10(%rbp)
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
