
printf_sharp_flag_leaves_infinity_and_nan_alone.x64:	file format elf64-x86-64

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
               	subq	$0x188, %rsp            # imm = 0x188
               	leaq	<rip>, %rdx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movss	<rip>, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	movsd	<rip>, %xmm5
               	leaq	<rip>, %r9
               	movapd	%xmm1, %xmm3
               	movapd	%xmm0, %xmm4
               	leaq	(%rsp), %rdi
               	movl	$0x80, %esi
               	movl	$0x7, %ecx
               	movl	$0xff, %r8d
               	movb	$0x6, %al
               	callq	<addr>
               	leaq	<rip>, %rsi
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
               	leaq	<rip>, %rdx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	leaq	0x80(%rsp), %rdi
               	movl	$0x40, %esi
               	movb	$0x3, %al
               	callq	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x80(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x188, %rsp            # imm = 0x188
               	retq
