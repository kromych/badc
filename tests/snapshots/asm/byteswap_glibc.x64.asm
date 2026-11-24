
byteswap_glibc.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movabsq	$0x102030405060708, %rax # imm = 0x102030405060708
               	movq	%rax, 0x18(%rsp)
               	movl	$0x11223344, 0x10(%rsp) # imm = 0x11223344
               	movw	$0xabcd, 0x8(%rsp)      # imm = 0xABCD
               	movzwq	0x8(%rsp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	cmpl	$0xcdab, %eax           # imm = 0xCDAB
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x10(%rsp), %eax
               	bswapl	%eax
               	cmpl	$0x44332211, %eax       # imm = 0x44332211
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	bswapq	%rax
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	cmpl	$0x807, %eax            # imm = 0x807
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	bswapl	%eax
               	cmpl	$0x8070605, %eax        # imm = 0x8070605
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movzwq	0x8(%rsp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	movzwq	0x8(%rsp), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x10(%rsp), %eax
               	bswapl	%eax
               	bswapl	%eax
               	movl	0x10(%rsp), %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	bswapq	%rax
               	bswapq	%rax
               	movq	0x18(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	movzwq	0x8(%rsp), %rax
               	movzwl	%ax, %eax
               	rolw	$0x8, %ax
               	movzwq	0x8(%rsp), %rcx
               	movzwl	%cx, %ecx
               	rolw	$0x8, %cx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x10(%rsp), %eax
               	bswapl	%eax
               	movl	0x10(%rsp), %ecx
               	bswapl	%ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	bswapq	%rax
               	movq	0x18(%rsp), %rcx
               	bswapq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
