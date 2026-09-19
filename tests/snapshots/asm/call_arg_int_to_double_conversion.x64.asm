
call_arg_int_to_double_conversion.x64:	file format elf64-x86-64

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
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %xmm0
               	movq	%rax, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%rcx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	movq	%rax, %xmm1
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
