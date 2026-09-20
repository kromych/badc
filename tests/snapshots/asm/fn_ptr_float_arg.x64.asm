
fn_ptr_float_arg.x64:	file format elf64-x86-64

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
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	mulss	%xmm15, %xmm0
               	cvttss2si	%xmm0, %rdx
               	cmpl	$0x5, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x40900000, %edx       # imm = 0x40900000
               	movq	%rdx, %xmm14
               	cvttss2si	%xmm14, %rdx
               	addq	$0x3, %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %xmm14
               	cvttss2si	%xmm14, %rax
               	addq	$0xa, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	mulss	%xmm15, %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
