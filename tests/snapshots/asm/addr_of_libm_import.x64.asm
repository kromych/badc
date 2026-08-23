
addr_of_libm_import.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	<rip>, %rax       # <addr>
               	movq	<rip>, %rbx       # <addr>
               	movq	<rip>, %r12       # <addr>
               	xorq	%r13, %r13
               	movq	%r13, %xmm0
               	callq	*%rax
               	movq	%r13, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rbx, %rax
               	movq	%rdi, %xmm0
               	callq	*%rax
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rdi # imm = 0x4000000000000000
               	movabsq	$0x4024000000000000, %rsi # imm = 0x4024000000000000
               	movq	%r12, %rax
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	callq	*%rax
               	movabsq	$0x4090000000000000, %rax # imm = 0x4090000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	xorq	%rbx, %rbx
               	movq	(%rax), %rax
               	movq	%rbx, %xmm0
               	callq	*%rax
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	xorq	%rbx, %rbx
               	movq	%rbx, %xmm0
               	callq	*%rax
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<__c5_sys_sin>:
               	jmp	<addr>

<__c5_sys_cos>:
               	jmp	<addr>
