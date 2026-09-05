
kernel_uaccess_phi_branch.x64:	file format elf64-x86-64

Disassembly of section .text:

<put_user_word>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	0x8(%rdi), %rax
               	movabsq	$0x7ffffffff000, %r11   # imm = 0x7FFFFFFFF000
               	cmpq	%r11, %rax
               	jbe	<addr>
               	movabsq	$-0xe, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	stac
               	movq	%rax, -0x20(%rbp)
               	movq	%rbx, -0x18(%rbp)
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, (%rax)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	clac
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<put_user_pair>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	0x10(%rdi), %rax
               	movabsq	$0x7ffffffff000, %r11   # imm = 0x7FFFFFFFF000
               	cmpq	%r11, %rax
               	jbe	<addr>
               	movabsq	$-0xe, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	stac
               	movq	%rax, -0x20(%rbp)
               	movq	%rbx, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rbx
               	movq	%rax, (%rbx)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	leaq	0x8(%rdi), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rbx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rbx
               	movq	%rax, (%rbx)
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rbx
               	clac
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	clac
               	movabsq	$-0xe, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
