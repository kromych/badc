
fp_contract_stays_within_an_expression.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm1 # <addr>
               	vmulss	<rip>, %xmm1, %xmm1
               	vsubss	<rip>, %xmm1, %xmm1
               	xorps	%xmm3, %xmm3
               	ucomiss	%xmm3, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	vmulsd	%xmm0, %xmm0, %xmm1
               	subsd	%xmm2, %xmm1
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movapd	%xmm2, %xmm1
               	vfmsub231sd	%xmm0, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm0) - xmm1
               	vxorpd	<rip>, %xmm2, %xmm2
               	vfmadd213sd	%xmm2, %xmm0, %xmm0 # xmm0 = (xmm0 * xmm0) + xmm2
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	retq
