
bitfield_attribute_after_width.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movb	$0x1, (%rax)
               	movb	$0x2, 0x9(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$-0x10, %rcx
               	orq	$0xd, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$-0xf1, %rcx
               	orq	$0x50, %rcx
               	movl	%ecx, 0x8(%rax)
               	movzbq	0x8(%rax), %rcx
               	xorq	$0x5d, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movsbq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movl	0x8(%rax), %ecx
               	sarq	$0x4, %rcx
               	andq	$0xf, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movsbq	0x9(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movb	$0x3, (%rax)
               	movb	$0x4, 0x11(%rax)
               	movl	0x8(%rax), %ecx
               	andq	$-0x10, %rcx
               	orq	$0x7, %rcx
               	movl	%ecx, 0x8(%rax)
               	movl	0x10(%rax), %ecx
               	andq	$-0x10, %rcx
               	orq	$0x8, %rcx
               	movl	%ecx, 0x10(%rax)
               	movsbq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	andq	$0xf, %rcx
               	shlq	$0x3c, %rcx
               	sarq	$0x3c, %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$-0x8, %eax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x11(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x6, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x48(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, (%rax)
               	movb	$0x6, 0x5(%rax)
               	movl	0x1(%rax), %edx
               	andq	$-0x40000000, %rdx      # imm = 0xC0000000
               	orq	$0x38a432eb, %rdx       # imm = 0x38A432EB
               	movl	%edx, 0x1(%rax)
               	movsbq	%cl, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$0xf8a432eb, %ecx       # imm = 0xF8A432EB
               	jne	<addr>
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movl	0x1(%rax), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x1fffffff, %rcx       # imm = 0x1FFFFFFF
               	movl	%ecx, 0x1(%rax)
               	leaq	-0x48(%rbp), %rax
               	movsbq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$0x1fffffff, %ecx       # imm = 0x1FFFFFFF
               	jne	<addr>
               	movsbq	0x5(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x70(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	movb	$0x8, 0x15(%rax)
               	movq	0x10(%rax), %rdx
               	movabsq	$-0x10000000000, %r11   # imm = 0xFFFFFF0000000000
               	andq	%r11, %rdx
               	movabsq	$0xfedcba9877, %r11     # imm = 0xFEDCBA9877
               	orq	%r11, %rdx
               	movq	%rdx, 0x10(%rax)
               	movsbq	%cl, %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movsbq	0x15(%rax), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movzbq	0x10(%rax), %rax
               	xorq	$0x77, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movl	$0x9, %ecx
               	movb	%cl, (%rax)
               	movb	$0xa, 0x9(%rax)
               	movsbq	%cl, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movb	$0xb, 0x2(%rax)
               	movzwq	(%rax), %rcx
               	andq	$-0x1000, %rcx          # imm = 0xF000
               	orq	$0x7ff, %rcx            # imm = 0x7FF
               	movw	%cx, (%rax)
               	movzwq	(%rax), %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	shlq	$0x34, %rcx
               	sarq	$0x34, %rcx
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movb	$0x12, (%rax)
               	movzwq	(%rax), %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	shlq	$0x34, %rcx
               	sarq	$0x34, %rcx
               	cmpl	$0x712, %ecx            # imm = 0x712
               	jne	<addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	movzwq	(%rax), %rcx
               	andq	$-0x1000, %rcx          # imm = 0xF000
               	orq	$0x800, %rcx            # imm = 0x800
               	movw	%cx, (%rax)
               	movzwq	(%rax), %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	shlq	$0x34, %rcx
               	sarq	$0x34, %rcx
               	cmpl	$0xfffff800, %ecx       # imm = 0xFFFFF800
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1b, %eax
               	leave
               	retq
