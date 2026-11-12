
libc_time_widths.x64:	file format elf64-x86-64

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
               	movabsq	$0x12a05f200, %rdi      # imm = 0x12A05F200
               	movl	$0x3b9aca00, %esi       # imm = 0x3B9ACA00
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x41edcd6500000000, %rax # imm = 0x41EDCD6500000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	cmpq	$0x63b0cd00, %rax       # imm = 0x63B0CD00
               	jge	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	subq	%rcx, %rax
               	cmpq	$0x5, %rax
               	jle	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
