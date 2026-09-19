
out_pointer_return_float_args.x64:	file format elf64-x86-64

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
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movl	$0x40800000, %esi       # imm = 0x40800000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rsi, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movl	$0x40600000, %edx       # imm = 0x40600000
               	movl	$0x40900000, %esi       # imm = 0x40900000
               	movl	$0x40b00000, %edi       # imm = 0x40B00000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rsi, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40b00000, %eax       # imm = 0x40B00000
               	movq	%rdi, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movabsq	$0x4034000000000000, %rcx # imm = 0x4034000000000000
               	movabsq	$0x403e000000000000, %rdx # imm = 0x403E000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
