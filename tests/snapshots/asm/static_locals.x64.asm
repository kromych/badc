
static_locals.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	movl	(%rax), %esi
               	addq	%rsi, %rdx
               	cmpl	$0xca, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	movl	(%rax), %esi
               	addq	%rsi, %rdx
               	cmpl	$0x131, %edx            # imm = 0x131
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x64, (%rax)
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rsi      # <addr>
               	movl	(%rsi), %edi
               	addq	%rdi, %rdx
               	movl	%edx, (%rsi)
               	movl	(%rcx), %ecx
               	addq	%rdx, %rcx
               	cmpl	$0xca, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %esi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	cmpl	$0x3e9, %esi            # imm = 0x3E9
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	(%rdx), %esi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movq	%rsi, %rdx
               	cmpl	$0x3ea, %edx            # imm = 0x3EA
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	(%rcx), %edx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	%rdx, %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	retq
