
kernel_bug_unreachable_tail.x64:	file format elf64-x86-64

Disassembly of section .text:

<redir>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	je	<addr>
               	leaq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.rodata-0x4
               	movl	$0x19, %ecx
               	xorq	%rdx, %rdx
               	movl	$0xc, %esi
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	ud2
               	ud2
               	movl	$0xa, %eax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	jmp	<addr>
               	cmpl	$0x2, %edi
               	jl	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	jmp	<addr>

<run_request>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	cmpl	$0x2, %edi
               	jl	<addr>
               	cmpl	$0x2, %edi
               	je	<addr>
               	leaq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.rodata+0x2b
               	movl	$0x2a, %ecx
               	xorq	%rdx, %rdx
               	movl	$0xc, %esi
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	ud2
               	ud2
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<trap_then_return>:
               	endbr64
               	testl	%edi, %edi
               	jge	<addr>
               	ud2
               	movslq	%edi, %rax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
