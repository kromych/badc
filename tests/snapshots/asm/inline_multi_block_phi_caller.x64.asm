
inline_multi_block_phi_caller.x64:	file format elf64-x86-64

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
               	movl	$0x1, %edx
               	leaq	<rip>, %rax
               	movl	(%rax), %r8d
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, %ecx
               	movl	$0xaaaaaaab, %esi       # imm = 0xAAAAAAAB
               	imulq	%rcx, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	movl	%edx, %esi
               	movl	%edi, %edi
               	cmpq	$0x1, %rdi
               	jb	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	%ecx, %edi
               	movl	%esi, %r9d
               	leaq	<rip>, %rcx
               	movl	%edi, %esi
               	andq	$0x3, %rsi
               	movl	%r9d, %edi
               	movl	%edi, (%rcx,%rsi,4)
               	movl	%edx, %ecx
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %edx
               	jmp	<addr>
               	movl	%ecx, %edi
               	movl	%esi, %r9d
               	leaq	<rip>, %rcx
               	movl	%edi, %esi
               	andq	$0x3, %rsi
               	movl	(%rcx,%rsi,4), %edi
               	movl	%r9d, %r9d
               	xorq	%r9, %rdi
               	movl	%edi, (%rcx,%rsi,4)
               	jmp	<addr>
               	movl	%ecx, %edi
               	movl	%esi, %r9d
               	leaq	<rip>, %rcx
               	movl	%edi, %esi
               	andq	$0x3, %rsi
               	movl	(%rcx,%rsi,4), %edi
               	movl	%r9d, %r9d
               	addq	%r9, %rdi
               	movl	%edi, (%rcx,%rsi,4)
               	jmp	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	movl	%r8d, %esi
               	cmpq	%rsi, %rcx
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
               	movslq	%eax, %rax
               	retq
