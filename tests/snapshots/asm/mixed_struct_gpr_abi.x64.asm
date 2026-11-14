
mixed_struct_gpr_abi.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	<rip>, %xmm1
               	movsd	-0x8(%rbp), %xmm0
               	movsd	<rip>, %xmm2
               	vfmadd231sd	%xmm2, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm2) + xmm1
               	cvttsd2si	%xmm1, %rax
               	addq	$0x2, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cvttsd2si	%xmm0, %rax
               	addq	$0x18, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
