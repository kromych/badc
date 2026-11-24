
init_scalar_conversion.x64:	file format elf64-x86-64

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

<rect_ok>:
               	subq	$0x28, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movsd	(%rsp), %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rsp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsd	0x10(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsd	0x18(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	addq	$0x28, %rsp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	subq	$0x28, %rsp
               	subq	$0x20, %rsp
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	leaq	0x20(%rsp), %r9
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	movsd	%xmm1, 0x30(%rsp)
               	movsd	%xmm2, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x30(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x38(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	addq	$0x28, %rsp
               	retq
