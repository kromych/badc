
fp_contract_stays_within_an_expression.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm3
               	vmulss	%xmm2, %xmm3, %xmm2
               	movss	<rip>, %xmm3
               	subss	%xmm3, %xmm2
               	xorps	%xmm3, %xmm3
               	ucomiss	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	vmulsd	%xmm0, %xmm0, %xmm2
               	subsd	%xmm1, %xmm2
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movapd	%xmm1, %xmm2
               	vfmsub231sd	%xmm0, %xmm0, %xmm2 # xmm2 = (xmm0 * xmm0) - xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vfmadd213sd	%xmm1, %xmm0, %xmm0 # xmm0 = (xmm0 * xmm0) + xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	retq
