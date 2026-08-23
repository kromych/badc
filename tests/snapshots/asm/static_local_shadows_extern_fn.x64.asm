
static_local_shadows_extern_fn.x64:	file format elf64-x86-64

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

<driver>:
               	xorq	%rax, %rax
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x2, %edi
               	je	<addr>
               	movslq	%eax, %rax
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>

<main>:
               	movl	$0x2a, %eax
               	movl	$0x2a, %eax
               	retq
