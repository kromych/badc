
function_end_reached_in_an_aggregate_function.x64:	file format elf64-x86-64

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

<memory>:
               	testl	%esi, %esi
               	je	<addr>
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	movq	(%rsp), %rax
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	retq

<integer>:
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	retq

<floating>:
               	subq	$0x18, %rsp
               	testl	%edi, %edi
               	je	<addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movsd	(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	addq	$0x18, %rsp
               	retq
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	movl	<rip>, %esi # <addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
