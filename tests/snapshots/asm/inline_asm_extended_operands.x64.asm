
inline_asm_extended_operands.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %rdx # imm = 0xFEDCBA9876543210
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x123456789abcdf0, %rbx # imm = 0xFEDCBA9876543210
               	shldq	$0xc, %rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3456789abcdeffed, %r11 # imm = 0x3456789ABCDEFFED
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rbx # imm = 0x123456789ABCDEF
               	shrdq	$0x14, %rbx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x432100123456789b, %r11 # imm = 0xBCDEFFEDCBA98765
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movl	%eax, -0x8(%rbp)
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	bswapl	%eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x44332211, %eax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	bswapq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rsi
               	rdtscp
               	shlq	$0x20, %rdx
               	orq	%rdx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%rsi)
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
