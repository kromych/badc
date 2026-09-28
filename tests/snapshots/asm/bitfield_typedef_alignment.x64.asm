
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
               	subq	$0x60, %rsp
               	leaq	-0x48(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x48(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movb	$0x2, 0x9(%rax)
               	movl	0x8(%rax), %edx
               	andq	$-0x8, %rdx
               	orq	$0x5, %rdx
               	movl	%edx, 0x8(%rax)
               	movsbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	andq	$0x7, %rcx
               	shlq	$0x3d, %rcx
               	sarq	$0x3d, %rcx
               	cmpl	$-0x3, %ecx
               	jne	<addr>
               	movsbq	0x9(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x6, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movb	$0x4, 0x5(%rax)
               	movl	0x1(%rax), %edx
               	andq	$-0x40000000, %rdx      # imm = 0xC0000000
               	orq	$0x38a432eb, %rdx       # imm = 0x38A432EB
               	movl	%edx, 0x1(%rax)
               	movsbq	%cl, %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$0xf8a432eb, %ecx       # imm = 0xF8A432EB
               	jne	<addr>
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	0x1(%rax), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x1fffffff, %rcx       # imm = 0x1FFFFFFF
               	movl	%ecx, 0x1(%rax)
               	leaq	-0x60(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$0x1fffffff, %ecx       # imm = 0x1FFFFFFF
               	jne	<addr>
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x58(%rbp), %rax
               	movb	$0x5, (%rax)
               	movb	$0x6, 0x6(%rax)
               	movq	(%rax), %rcx
               	movabsq	$-0xffffffffff01, %r11  # imm = 0xFFFF0000000000FF
               	andq	%r11, %rcx
               	movabsq	$0xfedcba987700, %r11   # imm = 0xFEDCBA987700
               	orq	%r11, %rcx
               	movq	%rcx, (%rax)
               	movsbq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	sarq	$0x8, %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movsbq	0x6(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movb	$0x7, (%rax)
               	movb	$0x8, 0x14(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$-0x8, %rcx
               	orq	$0x3, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x10(%rax), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x3edcba99, %rcx       # imm = 0x3EDCBA99
               	movl	%ecx, 0x10(%rax)
               	movsbq	(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	andq	$0x7, %rcx
               	shlq	$0x3d, %rcx
               	sarq	$0x3d, %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0xfedcba99, %eax       # imm = 0xFEDCBA99
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x14(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movl	$0x9, %ecx
               	movb	%cl, (%rax)
               	movb	$0xa, 0x9(%rax)
               	movzwq	0x8(%rax), %rdx
               	andq	$-0x10, %rdx
               	orq	$0x8, %rdx
               	movw	%dx, 0x8(%rax)
               	movsbq	%cl, %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movzwq	0x8(%rax), %rcx
               	andq	$0xf, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpl	$-0x8, %ecx
               	jne	<addr>
               	movsbq	0x9(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movb	$0xc, 0x5(%rax)
               	movb	$0xd, 0x6(%rax)
               	movl	0x1(%rax), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	movl	%ecx, 0x1(%rax)
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movsbq	0x6(%rax), %rcx
               	cmpl	$0xd, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x50(%rbp), %rax
               	movb	$0xb, 0x1(%rax)
               	movzbq	(%rax), %rcx
               	andq	$-0x8, %rcx
               	orq	$0x4, %rcx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	andq	$0x7, %rcx
               	shlq	$0x3d, %rcx
               	sarq	$0x3d, %rcx
               	cmpl	$-0x4, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
