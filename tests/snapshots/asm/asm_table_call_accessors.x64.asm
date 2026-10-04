
asm_table_call_accessors.x64:	file format elf64-x86-64

Disassembly of section .text:

<lock_irqsave>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	ops_table-0x4
               	movq	%rax, %r12
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	ops_table+0x4
               	movq	%rbx, %rdi
               	callq	<addr>
		R_X86_64_PLT32	lock_try-0x4
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
		R_X86_64_PLT32	lock_slowpath-0x4
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<unlock_irqrestore>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rsi, %rbx
               	callq	<addr>
		R_X86_64_PLT32	lock_release-0x4
               	testl	$0x200, %ebx            # imm = 0x200
               	je	<addr>
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	ops_table+0xc
               	popq	%rbx
               	leave
               	retq

<enable_irqs>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	ops_table+0xc
               	popq	%rbp
               	retq

<disable_irqs>:
               	endbr64
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rsp, %rax
               	callq	*(%rip)                 # <addr>
		R_X86_64_PC32	ops_table+0x4
               	popq	%rbp
               	retq
