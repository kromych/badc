
init_subdesignator_multi_dim.x64:	file format elf64-x86-64

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
               	movzwq	<rip>, %rax # <addr>
               	movzwq	<rip>, %rdx # <addr>
               	movzwq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	movl	<rip>, %r8d # <addr>
               	movl	<rip>, %r9d # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	cmpl	$0x7, %esi
               	jne	<addr>
               	movq	%rdi, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	%r8, %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movq	%r9, %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	cmpl	$0x7, %esi
               	jne	<addr>
               	cmpl	$0x5, %edi
               	jne	<addr>
               	cmpl	$0x6, %r8d
               	jne	<addr>
               	cmpl	$0x9, %r9d
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x2, %eax
               	retq
