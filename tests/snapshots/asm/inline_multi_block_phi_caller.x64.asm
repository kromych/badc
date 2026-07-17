
inline_multi_block_phi_caller.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax
               	movl	(%rax), %r8d
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %edx
               	movl	$0x3, %esi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rsi
               	movq	%rdx, %rdi
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, %esi
               	movl	%edi, %edi
               	cmpq	$0x1, %rdi
               	jb	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	%edx, %edi
               	movl	%esi, %r9d
               	leaq	<rip>, %rdx
               	movl	%edi, %esi
               	andq	$0x3, %rsi
               	movl	%r9d, %edi
               	movl	%edi, (%rdx,%rsi,4)
               	movl	%ecx, %ecx
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	jmp	<addr>
               	movl	%edx, %edi
               	movl	%esi, %r9d
               	leaq	<rip>, %rdx
               	movl	%edi, %esi
               	andq	$0x3, %rsi
               	movl	(%rdx,%rsi,4), %edi
               	movl	%r9d, %r9d
               	xorq	%r9, %rdi
               	movl	%edi, (%rdx,%rsi,4)
               	jmp	<addr>
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	%edx, %edi
               	movl	%esi, %r9d
               	leaq	<rip>, %rdx
               	movl	%edi, %esi
               	andq	$0x3, %rsi
               	movl	(%rdx,%rsi,4), %edi
               	movl	%r9d, %r9d
               	addq	%r9, %rdi
               	movl	%edi, (%rdx,%rsi,4)
               	jmp	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %edx
               	movl	%r8d, %esi
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0xc(%rax), %eax
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	andq	$0x7f, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	addb	%al, (%rax)
