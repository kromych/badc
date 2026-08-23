
byteswap_glibc.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	movq	%rax, -0x8(%rbp)
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movl	%eax, -0x10(%rbp)
               	movl	$0xabcd, %eax           # imm = 0xABCD
               	movw	%ax, -0x18(%rbp)
               	movzwq	-0x18(%rbp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	xorq	$0xcdab, %rax           # imm = 0xCDAB
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	bswapl	%eax
               	cmpl	$0x44332211, %eax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	bswapq	%rax
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	xorq	$0x807, %rax            # imm = 0x807
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	bswapl	%eax
               	cmpl	$0x8070605, %eax        # imm = 0x8070605
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movzwq	-0x18(%rbp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	movzwq	-0x18(%rbp), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	bswapl	%eax
               	bswapl	%eax
               	movl	-0x10(%rbp), %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	bswapq	%rax
               	bswapq	%rax
               	movq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movzwq	-0x18(%rbp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	movzwq	-0x18(%rbp), %rcx
               	movzwl	%cx, %ecx
               	rolw	$0x8, %cx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	-0x10(%rbp), %eax
               	bswapl	%eax
               	movl	-0x10(%rbp), %ecx
               	bswapl	%ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	bswapq	%rax
               	movq	-0x8(%rbp), %rcx
               	bswapq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
