
memcpy_oob_src.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x64, %edi
               	callq	<addr>
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rbx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rbx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movups	0x40(%rbx), %xmm14
               	movups	%xmm14, 0x40(%rax)
               	movups	0x50(%rbx), %xmm14
               	movups	%xmm14, 0x50(%rax)
               	movl	0x60(%rbx), %r10d
               	movl	%r10d, 0x60(%rax)
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
