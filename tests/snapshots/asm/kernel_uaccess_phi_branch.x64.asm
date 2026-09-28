
kernel_uaccess_phi_branch.x64:	file format elf64-x86-64

Disassembly of section .text:

<put_user_word>:
               	endbr64
               	leaq	0x8(%rdi), %rax
               	movabsq	$0x7ffffffff000, %r10   # imm = 0x7FFFFFFFF000
               	cmpq	%r10, %rax
               	ja	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	stac
               	movq	%rdi, %rax
               	movq	%rsi, %rbx
               	movq	%rbx, (%rax)
               	clac
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	movq	$-0xe, %rax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<put_user_pair>:
               	endbr64
               	leaq	0x10(%rdi), %rax
               	movabsq	$0x7ffffffff000, %r10   # imm = 0x7FFFFFFFF000
               	cmpq	%r10, %rax
               	ja	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	stac
               	movq	%rsi, %rax
               	movq	%rdi, %rbx
               	movq	%rax, (%rbx)
               	leaq	0x8(%rdi), %rax
               	movq	%rax, %rbx
               	movq	%rdx, %rax
               	movq	%rax, (%rbx)
               	clac
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	clac
               	movq	$-0xe, %rax
               	popq	%rbx
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	movq	$-0xe, %rax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
