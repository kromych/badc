
fn_ptr_return_type.x64:	file format elf64-x86-64

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

<anon>:
               	leaq	<rip>, %rax      # <addr>
               	retq

<vec>:
               	leaq	<rip>, %rax      # <addr>
               	retq

<go_s>:
               	leaq	-<rip>, %rax       # <addr>
               	retq

<go_i>:
               	leaq	-<rip>, %rax       # <addr>
               	retq

<main>:
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
