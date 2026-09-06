
builtin_bswap_reversal.x64:	file format elf64-x86-64

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

<swap16>:
               	movzwl	%di, %eax
               	rolw	$0x8, %ax
               	retq

<swap32>:
               	movl	%edi, %eax
               	bswapl	%eax
               	retq

<swap64>:
               	movq	%rdi, %rax
               	bswapq	%rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xabcd, %eax           # imm = 0xABCD
               	movw	%ax, -0x18(%rbp)
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movl	%eax, -0x10(%rbp)
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	movq	%rax, -0x8(%rbp)
               	movzwq	-0x18(%rbp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	cmpl	$0xcdab, %eax           # imm = 0xCDAB
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	-0x10(%rbp), %eax
               	bswapl	%eax
               	cmpl	$0x44332211, %eax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	bswapq	%rax
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	xorq	$0x807, %rax            # imm = 0x807
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	bswapl	%eax
               	cmpl	$0x8070605, %eax        # imm = 0x8070605
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	-0x10(%rbp), %eax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	xorq	$0x4433, %rax           # imm = 0x4433
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
