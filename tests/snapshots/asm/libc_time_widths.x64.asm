
libc_time_widths.x64:	file format elf64-x86-64

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
               	movabsq	$0x12a05f200, %rdi      # imm = 0x12A05F200
               	movl	$0x3b9aca00, %esi       # imm = 0x3B9ACA00
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	$0x0, 0x18(%rsp)
               	movq	%rcx, 0x8(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpq	$0x63b0cd00, %rcx       # imm = 0x63B0CD00
               	jge	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	cmpq	%rcx, %rax
               	jl	<addr>
               	subq	%rcx, %rax
               	cmpq	$0x5, %rax
               	jle	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
