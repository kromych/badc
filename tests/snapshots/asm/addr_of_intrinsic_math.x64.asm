
addr_of_intrinsic_math.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax       # <addr>
               	movabsq	$-0x3ff4000000000000, %rcx # imm = 0xC00C000000000000
               	movq	%rcx, %xmm0
               	callq	*%rax
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4030000000000000, %rax # imm = 0x4030000000000000
               	movq	<rip>, %rcx       # <addr>
               	movq	%rax, %xmm0
               	callq	*%rcx
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x400599999999999a, %rax # imm = 0x400599999999999A
               	movq	<rip>, %rcx       # <addr>
               	movq	%rax, %xmm0
               	callq	*%rcx
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4000cccccccccccd, %rax # imm = 0x4000CCCCCCCCCCCD
               	movq	<rip>, %rcx       # <addr>
               	movq	%rax, %xmm0
               	callq	*%rcx
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4007333333333333, %rax # imm = 0x4007333333333333
               	movq	<rip>, %rcx       # <addr>
               	movq	%rax, %xmm0
               	callq	*%rcx
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x3fde000000000000, %rax # imm = 0xC022000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4054400000000000, %rax # imm = 0x4054400000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x401799999999999a, %rax # imm = 0x401799999999999A
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movabsq	$-0x3fe4000000000000, %rcx # imm = 0xC01C000000000000
               	movq	%rcx, %xmm0
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, %xmm15
               	andpd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4048800000000000, %rax # imm = 0x4048800000000000
               	movq	%rax, %xmm0
               	sqrtsd	%xmm0, %xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<__c5_sys_sqrt>:
               	jmp	<addr>

<__c5_sys_fabs>:
               	jmp	<addr>

<__c5_sys_floor>:
               	jmp	<addr>
