
const_fnptr_arg_direct_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<read_field>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r14
               	leaq	-0x20(%rbp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movups	%xmm14, 0x10(%r12)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movl	$0x1a, %r13d
               	movl	$0xa, %ebx
               	jmp	<addr>
               	decq	%rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	addl	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	nest_count-0x5
               	movb	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	cache_dirty-0x5
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
		R_X86_64_PLT32	entry_ret-0x4
               	subl	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	nest_count-0x5
               	movq	%rsp, %rcx
               	callq	<addr>
		R_X86_64_PLT32	resched_thunk-0x4
               	movabsq	$-0x7ffffdfd00000000, %r11 # imm = 0x8000020300000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	-0x10(%rbp), %rcx
               	movq	%rcx, (%r14)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	jmp	<addr>
		R_X86_64_PLT32	__x86_return_thunk-0x4

<enter_entry>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, (%rsi)
               	xorl	%edi, %edi
               	movb	$0x1, (%rip)            # <addr>
		R_X86_64_PC32	cache_dirty-0x5
               	popq	%rbp
               	jmp	<addr>
		R_X86_64_PLT32	entry_saved_ret-0x4
