
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
               	movb	$0x1, -0x38(%rbp)
               	movb	$0x2, -0x2f(%rbp)
               	movl	-0x30(%rbp), %eax
               	andq	$-0x10, %rax
               	orq	$0xd, %rax
               	movl	%eax, -0x30(%rbp)
               	movl	-0x30(%rbp), %eax
               	andq	$-0xf1, %rax
               	orq	$0x50, %rax
               	movl	%eax, -0x30(%rbp)
               	movzbq	-0x30(%rbp), %rax
               	xorq	$0x5d, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movsbq	-0x38(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	sarq	$0x4, %rax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movsbq	-0x2f(%rbp), %rax
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
               	movb	$0x3, -0x18(%rbp)
               	movb	$0x4, -0x7(%rbp)
               	movl	-0x10(%rbp), %eax
               	andq	$-0x10, %rax
               	orq	$0x7, %rax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x8(%rbp), %eax
               	andq	$-0x10, %rax
               	orq	$0x8, %rax
               	movl	%eax, -0x8(%rbp)
               	movsbq	-0x18(%rbp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$-0x8, %eax
               	jne	<addr>
               	movsbq	-0x7(%rbp), %rax
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
               	movb	%cl, -0x48(%rbp)
               	movb	$0x6, -0x43(%rbp)
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
               	movsbq	-0x43(%rbp), %rcx
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
               	movsbq	-0x48(%rbp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0x1fffffff, %eax       # imm = 0x1FFFFFFF
               	jne	<addr>
               	movsbq	-0x43(%rbp), %rax
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
               	movl	$0x7, %eax
               	movb	%al, -0x70(%rbp)
               	movb	$0x8, -0x5b(%rbp)
               	movq	-0x60(%rbp), %rcx
               	movabsq	$-0x10000000000, %r11   # imm = 0xFFFFFF0000000000
               	andq	%r11, %rcx
               	movabsq	$0xfedcba9877, %r11     # imm = 0xFEDCBA9877
               	orq	%r11, %rcx
               	movq	%rcx, -0x60(%rbp)
               	movsbq	%al, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movq	-0x60(%rbp), %rax
               	movabsq	$0xffffffffff, %r11     # imm = 0xFFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	-0x5b(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movzbq	-0x60(%rbp), %rax
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
               	movl	$0x9, %eax
               	movb	%al, -0x28(%rbp)
               	movb	$0xa, -0x1f(%rbp)
               	movsbq	%al, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movb	$0xb, -0x3e(%rbp)
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
               	movsbq	-0x3e(%rbp), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movb	$0x12, -0x40(%rbp)
               	movzwq	(%rax), %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	shlq	$0x34, %rax
               	sarq	$0x34, %rax
               	cmpl	$0x712, %eax            # imm = 0x712
               	jne	<addr>
               	movsbq	-0x3e(%rbp), %rax
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
               	movzwq	(%rax), %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	shlq	$0x34, %rax
               	sarq	$0x34, %rax
               	cmpl	$0xfffff800, %eax       # imm = 0xFFFFF800
               	jne	<addr>
               	cmpb	$0x0, -0x40(%rbp)
               	jne	<addr>
               	movsbq	-0x3e(%rbp), %rax
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
