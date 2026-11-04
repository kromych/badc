
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
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x40600000, %ecx       # imm = 0x40600000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vmulss	%xmm15, %xmm14, %xmm0
               	cvttss2si	%xmm0, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
