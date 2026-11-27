
arrays_basic.x64:	file format elf64-x86-64

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
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, 0x10(%rsp)
               	movl	$0x5, 0x18(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	0x8(%rsp,%rax,4), %esi
               	addq	%rsi, %rcx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	movabsq	$0xa00000000, %rcx      # imm = 0xA00000000
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x1e00000014, %rcx     # imm = 0x1E00000014
               	movq	%rcx, <rip> # <addr>
               	movl	$0x28, <rip> # <addr>
               	movw	$0x6968, <rip> # imm = 0x6968
                                                # <addr>
               	movb	%al, <rip> # <addr>
               	movl	0x10(%rsp), %ecx
               	movl	0x14(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x18(%rsp), %edx
               	addq	%rdx, %rcx
               	cmpl	$0xc, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	addq	$0x28, %rsp
               	retq
