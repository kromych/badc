
indirect_call_mixed_fp_int_args.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	leaq	0x2(%rax), %rcx
               	movabsq	$0x4024000000000000, %rdx # imm = 0x4024000000000000
               	movq	%rdx, %xmm15
               	mulsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	$0x19, %rax
               	addq	$0x3, %rax
               	leaq	0x7(%rax), %rcx
               	cmpl	$0x40, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	addq	$0x7, %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
