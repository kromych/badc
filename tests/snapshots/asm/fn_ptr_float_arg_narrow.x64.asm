
fn_ptr_float_arg_narrow.x64:	file format elf64-x86-64

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

<scale2>:
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	retq

<negf>:
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	retq

<addf>:
               	addss	%xmm1, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x40400000, %edi       # imm = 0x40400000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40400000, %ebx       # imm = 0x40400000
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40800000, %edi       # imm = 0x40800000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movl	$0x41000000, %eax       # imm = 0x41000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3fc00000, %edi       # imm = 0x3FC00000
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	callq	<addr>
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	mulss	%xmm15, %xmm0
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x28(%rbp,%riz)
               	movss	-0x28(%rbp,%riz), %xmm0
               	callq	<addr>
               	movl	$0x41600000, %eax       # imm = 0x41600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40400000, %edi       # imm = 0x40400000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40400000, %edi       # imm = 0x40400000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movl	$0x40c00000, %eax       # imm = 0x40C00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3fc00000, %edi       # imm = 0x3FC00000
               	movl	$0x40000000, %esi       # imm = 0x40000000
               	movq	%rdi, %xmm0
               	movq	%rsi, %xmm1
               	callq	<addr>
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
