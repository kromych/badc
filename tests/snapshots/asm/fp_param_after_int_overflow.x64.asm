
fp_param_after_int_overflow.x64:	file format elf64-x86-64

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

<tail_double>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	retq

<main>:
               	pushq	%rax
               	subq	$0x20, %rsp
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movsd	<rip>, %xmm0
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	$0x9, 0x10(%rsp)
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%r11
               	retq
               	movl	$0xa, %edi
               	movl	$0x14, %esi
               	movl	$0x1e, %edx
               	movl	$0x28, %ecx
               	movl	$0x32, %r8d
               	movl	$0x3c, %r9d
               	movsd	<rip>, %xmm0
               	movq	$0x46, (%rsp)
               	movq	$0x50, 0x8(%rsp)
               	movq	$0x5a, 0x10(%rsp)
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	popq	%r11
               	retq
