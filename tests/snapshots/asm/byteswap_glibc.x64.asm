
byteswap_glibc.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	movq	%rax, -0x8(%rbp)
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movl	%eax, -0x10(%rbp)
               	movl	$0xabcd, %eax           # imm = 0xABCD
               	movw	%ax, -0x18(%rbp)
               	movzwq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x8, %rcx
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	xorq	$0xcdab, %rax           # imm = 0xCDAB
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	cmpq	$0x44332211, %rax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x38, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x28, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x28, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x30, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x38, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$0xff, %rax
               	shlq	$0x8, %rax
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	orq	%rcx, %rax
               	xorq	$0x807, %rax            # imm = 0x807
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rcx
               	movl	%ecx, %eax
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	cmpq	$0x8070605, %rax        # imm = 0x8070605
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movzwq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x8, %rcx
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$0xff, %rax
               	shlq	$0x8, %rax
               	shrq	$0x8, %rcx
               	andq	$0xff, %rcx
               	orq	%rcx, %rax
               	movzwq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rax, %rcx
               	movl	%ecx, %eax
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	movl	-0x10(%rbp), %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x38, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x28, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x28, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x30, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x38, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x38, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x28, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x28, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x30, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x38, %rax
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movzwq	-0x18(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x8, %rcx
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	orq	%rax, %rcx
               	movzwq	-0x18(%rbp), %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	shrq	$0x8, %rax
               	andq	$0xff, %rax
               	orq	%rdx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x18, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rax, %rcx
               	movl	-0x10(%rbp), %eax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x18, %rdx
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x8, %rsi
               	orq	%rsi, %rdx
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	orq	%rdx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	shlq	$0x38, %rcx
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x10, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x28, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x18, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x18, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x28, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	shrq	$0x30, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x8, %rdx
               	orq	%rdx, %rcx
               	shrq	$0x38, %rax
               	andq	$0xff, %rax
               	orq	%rax, %rcx
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	shlq	$0x38, %rdx
               	movq	%rax, %rsi
               	shrq	$0x8, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x30, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x28, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x18, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x18, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x28, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rdx
               	movq	%rax, %rsi
               	shrq	$0x30, %rsi
               	andq	$0xff, %rsi
               	shlq	$0x8, %rsi
               	orq	%rsi, %rdx
               	shrq	$0x38, %rax
               	andq	$0xff, %rax
               	orq	%rdx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
