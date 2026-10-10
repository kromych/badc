
packed_member_declaration.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	movb	$0x7, -0x20(%rbp)
               	movb	$0x7, -0x1b(%rbp)
               	leaq	0x5(%rax), %rcx
               	movl	$0x11223344, 0x1(%rcx)  # imm = 0x11223344
               	movsbq	(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movzbq	-0x1b(%rbp), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x1a(%rbp), %rcx
               	xorq	$0x44, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	-0x17(%rbp), %rcx
               	xorq	$0x11, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0xfffffffb, 0x1(%rax)  # imm = 0xFFFFFFFB
               	movsbq	-0x20(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x6(%rax), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, -0x10(%rbp)
               	movl	$0x1020304, 0x1(%rax)   # imm = 0x1020304
               	movl	$0xfffffff9, 0x5(%rax)  # imm = 0xFFFFFFF9
               	movb	$0x9, -0x7(%rbp)
               	movsbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %ecx
               	cmpl	$0x1020304, %ecx        # imm = 0x1020304
               	jne	<addr>
               	movl	0x5(%rax), %eax
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x6, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, -0x38(%rbp)
               	movb	$0x2, -0x33(%rbp)
               	movl	0x1(%rax), %edx
               	andq	$-0x40000000, %rdx      # imm = 0xC0000000
               	orq	$0x38a432eb, %rdx       # imm = 0x38A432EB
               	movl	%edx, 0x1(%rax)
               	movsbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %ecx
               	andq	$0x3fffffff, %rcx       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rcx
               	sarq	$0x22, %rcx
               	cmpl	$0xf8a432eb, %ecx       # imm = 0xF8A432EB
               	jne	<addr>
               	movsbq	-0x33(%rbp), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	0x1(%rax), %ecx
               	andq	$-0x40000000, %rcx      # imm = 0xC0000000
               	orq	$0x1fffffff, %rcx       # imm = 0x1FFFFFFF
               	movl	%ecx, 0x1(%rax)
               	leaq	-0x38(%rbp), %rax
               	movsbq	-0x38(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %eax
               	andq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	shlq	$0x22, %rax
               	sarq	$0x22, %rax
               	cmpl	$0x1fffffff, %eax       # imm = 0x1FFFFFFF
               	jne	<addr>
               	movsbq	-0x33(%rbp), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x30(%rbp), %rax
               	movb	$0x3, -0x30(%rbp)
               	movl	-0x30(%rbp), %ecx
               	andq	$-0xfffff01, %rcx       # imm = 0xF00000FF
               	orq	$0x8000100, %rcx        # imm = 0x8000100
               	movl	%ecx, -0x30(%rbp)
               	movl	0x3(%rax), %ecx
               	andq	$-0xfffff1, %rcx        # imm = 0xFF00000F
               	orq	$0x7ffff0, %rcx         # imm = 0x7FFFF0
               	movl	%ecx, 0x3(%rax)
               	movb	$0x4, -0x2a(%rbp)
               	movsbq	-0x30(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	-0x30(%rbp), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	cmpl	$0xfff80001, %ecx       # imm = 0xFFF80001
               	jne	<addr>
               	movl	0x3(%rax), %eax
               	sarq	$0x4, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$0x7ffff, %eax          # imm = 0x7FFFF
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movl	0x3(%rax), %ecx
               	andq	$-0xfffff1, %rcx        # imm = 0xFF00000F
               	orq	$0xfffff0, %rcx         # imm = 0xFFFFF0
               	movl	%ecx, 0x3(%rax)
               	movl	-0x30(%rbp), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	cmpl	$0xfff80001, %ecx       # imm = 0xFFF80001
               	jne	<addr>
               	movl	0x3(%rax), %eax
               	sarq	$0x4, %rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movsbq	-0x2a(%rbp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x7, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movb	$0x5, -0x28(%rbp)
               	movb	$0x6, -0x22(%rbp)
               	movl	0x1(%rax), %ecx
               	movzbq	-0x23(%rbp), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x10000000000, %r11   # imm = 0xFFFFFF0000000000
               	andq	%r11, %rcx
               	movabsq	$0x7fffffffff, %r11     # imm = 0x7FFFFFFFFF
               	orq	%r11, %rcx
               	movl	%ecx, 0x1(%rax)
               	shrq	$0x20, %rcx
               	movb	%cl, -0x23(%rbp)
               	movsbq	-0x28(%rbp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %ecx
               	movzbq	-0x23(%rbp), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$0x7fffffffff, %r11     # imm = 0x7FFFFFFFFF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movsbq	-0x22(%rbp), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	0x1(%rax), %ecx
               	movzbq	-0x23(%rbp), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x10000000000, %r11   # imm = 0xFFFFFF0000000000
               	andq	%r11, %rcx
               	movabsq	$0xfedcba9877, %r11     # imm = 0xFEDCBA9877
               	orq	%r11, %rcx
               	movl	%ecx, 0x1(%rax)
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	movb	%al, -0x23(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movsbq	-0x28(%rbp), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x1(%rax), %eax
               	movzbq	-0x23(%rbp), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsbq	-0x22(%rbp), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x16, %eax
               	leave
               	retq
               	movl	$0xd, %eax
               	leave
               	retq
