
stac_region_phi_branch.x64:	file format elf64-x86-64

Disassembly of section .text:

<put_user_word>:
               	endbr64
               	leaq	0x8(%rdi), %rax
               	movabsq	$0x7ffffffff000, %r11   # imm = 0x7FFFFFFFF000
               	cmpq	%r11, %rax
               	jbe	<addr>
               	movq	$-0xe, %rax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	stac
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	clac
               	xorl	%eax, %eax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<put_user_pair>:
               	endbr64
               	leaq	0x10(%rdi), %rax
               	movabsq	$0x7ffffffff000, %r11   # imm = 0x7FFFFFFFF000
               	cmpq	%r11, %rax
               	jbe	<addr>
               	movq	$-0xe, %rax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	stac
               	movq	%rsi, %rax
               	movq	%rdi, %rcx
               	movq	%rax, (%rcx)
               	leaq	0x8(%rdi), %rax
               	movq	%rax, %rcx
               	movq	%rdx, %rax
               	movq	%rax, (%rcx)
               	clac
               	xorl	%eax, %eax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
               	clac
               	movq	$-0xe, %rax
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4
