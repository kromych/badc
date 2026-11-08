
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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rcx
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	movb	$0x0, -0x4(%rbp)
               	movb	$0x0, -0x3(%rbp)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x2, -0x3(%rbp)
               	movl	0x1(%rcx), %edx
               	andq	$-0x40000000, %rdx      # imm = 0xC0000000
               	orq	$0x38a432eb, %rdx       # imm = 0x38A432EB
               	movl	%edx, 0x1(%rcx)
               	movq	%rdx, %rsi
               	shlq	$0x22, %rsi
               	sarq	$0x22, %rsi
               	cmpl	$0xf8a432eb, %esi       # imm = 0xF8A432EB
               	jne	<addr>
               	andq	$-0x40000000, %rdx      # imm = 0xC0000000
               	orq	$0x1fffffff, %rdx       # imm = 0x1FFFFFFF
               	movl	%edx, 0x1(%rcx)
               	shlq	$0x22, %rdx
               	sarq	$0x22, %rdx
               	cmpl	$0x1fffffff, %edx       # imm = 0x1FFFFFFF
               	jne	<addr>
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x4(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movb	$0x3, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	andq	$-0xfffff01, %rcx       # imm = 0xF00000FF
               	orq	$0x8000100, %rcx        # imm = 0x8000100
               	movl	%ecx, -0x8(%rbp)
               	movl	0x3(%rax), %ecx
               	andq	$-0xfffff1, %rcx        # imm = 0xFF00000F
               	orq	$0x7ffff0, %rcx         # imm = 0x7FFFF0
               	movl	%ecx, 0x3(%rax)
               	movb	$0x4, -0x2(%rbp)
               	movsbq	-0x8(%rbp), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	-0x8(%rbp), %ecx
               	sarq	$0x8, %rcx
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	cmpl	$0xfff80001, %ecx       # imm = 0xFFF80001
               	jne	<addr>
               	movl	0x3(%rax), %eax
               	sarq	$0x4, %rax
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$0x7ffff, %eax          # imm = 0x7FFFF
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movl	0x3(%rcx), %eax
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	orq	$0xfffff0, %rax         # imm = 0xFFFFF0
               	movl	%eax, 0x3(%rcx)
               	movl	-0x8(%rbp), %edx
               	sarq	$0x8, %rdx
               	shlq	$0x2c, %rdx
               	sarq	$0x2c, %rdx
               	cmpl	$0xfff80001, %edx       # imm = 0xFFF80001
               	jne	<addr>
               	movl	%eax, %eax
               	sarq	$0x4, %rax
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movsbq	-0x2(%rbp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movb	%al, -0x8(%rbp)
               	movb	%al, -0x7(%rbp)
               	movb	%al, -0x6(%rbp)
               	movb	%al, -0x5(%rbp)
               	movb	%al, -0x4(%rbp)
               	movb	%al, -0x3(%rbp)
               	movb	%al, -0x2(%rbp)
               	movb	$0x5, -0x8(%rbp)
               	movb	$0x6, -0x2(%rbp)
               	movl	0x1(%rcx), %edx
               	movabsq	$-0x10000000000, %r11   # imm = 0xFFFFFF0000000000
               	andq	%r11, %rdx
               	movabsq	$0x7fffffffff, %r11     # imm = 0x7FFFFFFFFF
               	orq	%r11, %rdx
               	movl	%edx, 0x1(%rcx)
               	shrq	$0x20, %rdx
               	movb	%dl, -0x3(%rbp)
               	andq	$0xff, %rdx
               	shlq	$0x20, %rdx
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	orq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x18, %rdx
               	sarq	$0x18, %rdx
               	movabsq	$0x7fffffffff, %r11     # imm = 0x7FFFFFFFFF
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movabsq	$-0x10000000000, %r11   # imm = 0xFFFFFF0000000000
               	andq	%r11, %rcx
               	movabsq	$0xfedcba9877, %r11     # imm = 0xFEDCBA9877
               	orq	%r11, %rcx
               	movl	%ecx, 0x1(%rdx)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movb	%dl, -0x3(%rbp)
               	movl	%ecx, %ecx
               	andq	$0xff, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	shlq	$0x18, %rcx
               	sarq	$0x18, %rcx
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rcx
               	jne	<addr>
               	leave
               	retq
               	movl	$0x19, %eax
               	leave
               	retq
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	$0x16, %eax
               	leave
               	retq
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	$0x14, %eax
               	leave
               	retq
